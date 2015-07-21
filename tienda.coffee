Item = new Mongo.Collection 'items'

if Meteor.isClient
  Session.setDefault 'counter', 0


  Template.addItem.events
    'click .save': (evt) ->
      evt.preventDefault()

      name = $('.name').val()
      code = $('.code').val()

      if name == ''
        alert 'falta nombre'
        return
      if code == ''
        alert 'falta codigo'
        return

      ct4 = parseInt($('.ct4').val()) || 0
      pt4 = parseInt($('.pt4').val()) || 0

      ct6 = parseInt($('.ct6').val()) || 0
      pt6 = parseInt($('.pt6').val()) || 0

      ct8 = parseInt($('.ct8').val()) || 0
      pt8 = parseInt($('.pt8').val()) || 0

      ct10 = parseInt($('.ct10').val()) || 0
      pt10 = parseInt($('.pt10').val()) || 0

      ct12 = parseInt($('.ct12').val()) || 0
      pt12 = parseInt($('.pt12').val()) || 0
      ct14 = parseInt($('.ct14').val()) || 0
      pt14 = parseInt($('.pt14').val()) || 0
      cts = parseInt($('.cts').val()) || 0
      pts = parseInt($('.pts').val()) || 0
      ctm = parseInt($('.ctm').val()) || 0
      ptm = parseInt($('.ptm').val()) || 0
      ctl = parseInt($('.ctl').val()) || 0
      ptl = parseInt($('.ptl').val()) || 0
      ctxl = parseInt($('.ctxl').val()) || 0
      ptxl = parseInt($('.ptxl').val()) || 0
      ctxxl = parseInt($('.ctxxl').val()) || 0
      ptxxl = parseInt($('.ptxxl').val()) || 0
      ct3xl = parseInt($('.ct3xl').val()) || 0
      pt3xl = parseInt($('.pt3xl').val()) || 0

      item =
        name: name
        code: code
        t4:
          c: ct4
          p: pt4
        t6:
          c: ct6
          p: pt6
        t8:
          c: ct8
          p: pt8
        t10:
          c: ct10
          p: pt10
        t12:
          c: ct12
          p: pt12
        t14:
          c: ct14
          p: pt14
        ts:
          c: cts
          p: pts
        tm:
          c: ctm
          p: ptm
        tl:
          c: ctl
          p: ptl
        txl:
          c: ctxl
          p: ptxl
        txxl:
          c: ctxxl
          p: ptxxl
        t3xl:
          c: ct3xl
          p: pt3xl

        tt4: pt4*ct4
        tt6: pt6*ct6
        tt8: pt8*ct8
        tt10: pt10*ct10
        tt12: pt12*ct12
        tt14: pt14*ct14
        tts: pts*cts
        ttm: ptm*ctm
        ttl: ptl*ctl
        ttxl: ptxl*ctxl
        ttxxl: ptxxl*ctxxl
        tt3xl: pt3xl*ct3xl


      Item.insert item

  Template.itemList.helpers
    items: ->
      Item.find()
    calcTotal: (a, b) ->
      a * b

  Template.item.events
    'click .delete': (evt) ->
      evt.preventDefault()
      Item.remove @_id

if (Meteor.isServer)
  Meteor.startup ->