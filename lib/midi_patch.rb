require 'midilib'
require_relative 'audulus'
require_relative 'spline_helper'
require 'pry'

module MidiPatch
  STEPWISE_X_DELTA = 0.0001

  def self.build_patch(path)
    seq = MIDI::Sequence.new()

    File.open(path, 'rb') do |file|
      seq.read(file)
    end

    doc = Audulus.build_init_doc
    patch = doc['patch']

    pitch_node = build_pitch_node(seq)
    Audulus.add_node(patch, pitch_node)
    Audulus.move_node(pitch_node, 0, 0)

    scaler_node = Audulus.build_expr_node('x*10-5')
    Audulus.add_node(patch, scaler_node)
    Audulus.move_node(scaler_node, 425, 55)
    Audulus.wire_output_to_input(patch, pitch_node, 0, scaler_node, 0)

    pitch_label = Audulus.build_text_node("pitch")
    Audulus.add_node(patch, pitch_label)
    Audulus.move_node(pitch_label, -50, 100)

    gate_node = build_gate_node(seq)
    Audulus.add_node(patch, gate_node)
    Audulus.move_node(gate_node, 0, 200)

    pitch_label = Audulus.build_text_node("gate")
    Audulus.add_node(patch, pitch_label)
    Audulus.move_node(pitch_label, -50, 300)

    _, file = File.expand_path(path).split("/")[-2..-1]
    basename = File.basename(file, ".mid")
    File.write("#{basename}.audulus", JSON.generate(doc))
  end

  def self.build_pitch_node(seq)
    note_on_events = seq.first.select {|e| MIDI::NoteOn === e}

    times = note_on_events.map(&:time_from_start)
    min_time, max_time = [times.min, times.max].map(&:to_f)
    scaled_times = times.map {|time|
      scale_time(time, min_time, max_time)
    }

    notes = note_on_events.map(&:note)
    scaled_notes = notes.map {|note|
      one_per_octave = (note.to_f - 69.0)/12.0
      (one_per_octave+5)/10 # scale to be > 0
    }

    coordinates = scaled_times.zip(scaled_notes)
    stepwise_coordinates = make_stepwise(coordinates)
    SplineHelper.build_spline_node_from_coordinates(stepwise_coordinates)
  end

  def self.build_gate_node(seq)
    note_on_off_events = seq.first.select {|e| MIDI::NoteOn === e || MIDI::NoteOff === e}

    note_stack = []

    times = note_on_off_events.map(&:time_from_start)
    min_time, max_time = [times.min, times.max].map(&:to_f)
    coordinates = note_on_off_events.map {|event|
      time = scale_time(event.time_from_start, min_time, max_time)
      case event
      when MIDI::NoteOn
        add_to_stack(note_stack, event)
        [time, scale_velocity(event.velocity)]
      when MIDI::NoteOff
        remove_from_stack(note_stack, event)
        if note_stack.empty?
          [time, 0.0]
        else
          [time, scale_velocity(note_stack[-1].velocity)]
        end
      end
    }

    stepwise_coordinates = make_stepwise(coordinates)
    SplineHelper.build_spline_node_from_coordinates(stepwise_coordinates)
  end

  def self.scale_time(time, min_time, max_time)
    (time - min_time).to_f / (max_time - min_time).to_f
  end

  def self.scale_velocity(velocity)
    velocity.to_f / 127.0
  end

  def self.add_to_stack(stack, event)
    stack << event
  end

  def self.remove_from_stack(stack, event)
    stack.delete_if {|e| e.note == event.note}
  end

  def self.make_stepwise(coordinates)
    last_y = nil
    coordinates.flat_map {|x, y|
      result = []
      result << [x-STEPWISE_X_DELTA, last_y] unless last_y.nil?
      result << [x, y]
      last_y = y
      result
    }
  end
end
