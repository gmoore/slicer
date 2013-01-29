# Slicer

A gem to slice your data and present it in such a way so as to be consumed by d3.js, specifically the sunburst visualization (although there's no reason it couldn't be consumed by some other vis).

For a fantastic example of the sunburst vis, please see the [coffee flavor wheel](http://www.jasondavies.com/coffee-wheel/)  Go look at that now and the rest of this README will make a lot more sense.

This gem is in production use on [Artful.ly](http://www.artful.ly).  We'll have a full end-to-end example (including js) soon on [Artful.ly open source](http://www.artful.ly/opensource)

## Install

    gem install slicer

## Usage

Slicer needs the following as input:

* A root slice (pass nil and Slicer will create one for you)
* An Array of things on which to operate.  These can be whatever your system is interested in: items, tickets, widgets, metrics, whatever.
* An Array of Proc objects to use to act on those things

In return, slicer will give you:

* A Slice object, with children.  The root Slice class represents the innermost ring of the vis.  Children are the outer rings.

## Your Procs

The procs that you pass to slicer should return a Hash, for each element:

* the **key** is the label of the slice
* the **value** is the array of things that apply

For example, say you're slicing up purchased_items by payment method.  Your proc would look something like

    self.payment_method_proc = Proc.new do |items|
      payment_method_map = {}
      items.each do |item|
        item_array = payment_method_map[item.payment_method]
        item_array ||= []
        item_array << item
        payment_method_map[item.payment_method] = item_array
      end
      payment_method_map
    end
    
This proc returns something like

    {
      :credit_card  => some_items,
      :cash     => some_other_items
    }
    
And you would pass this proc to Slicer

    Slicer.slice(Slice.new("All Sales"), purchased_items, [payment_method_proc])

If you have more procs, pass them in.  They'll get sliced in the order you provide.

    Slicer.slice(Slice.new("All Sales"), purchased_items, [payment_method_proc, location_proc, big_spender_proc])

## TODO

* A more thorough example
* Better coloring

## Credits

Big hat tip and thanks to the good people working on [D3.js](http://d3js.org/), specifically Mike Bostok.  Thanks to Jason Davies for his [Zoomable Sunburst example](http://www.jasondavies.com/coffee-wheel/) for providing the inspiration for this.
