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
      date = new Date()

      item =
        name: name
        code: code
        date: date

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

        ct4: ct4
        ct6: ct6
        ct8: ct8
        ct10: ct10
        ct12: ct12
        ct14: ct14
        cts: cts
        ctm: ctm
        ctl: ctl
        ctxl: ctxl
        ctxxl: ctxxl
        ct3xl: ct3xl

        pt4: pt4
        pt6: pt6
        pt8: pt8
        pt10: pt10
        pt12: pt12
        pt14: pt14
        pts: pts
        ptm: ptm
        ptl: ptl
        ptxl: ptxl
        ptxxl: ptxxl
        pt3xl: pt3xl


      Item.insert item

  Template.itemList.helpers
    items: ->
      Item.find({}, {sort:{date:-1}})
    calcTotal: (a, b) ->
      a * b

  Template.item.events
    'click .delete': (evt) ->
      evt.preventDefault()
      Item.remove @_id

  Template.backup.events
    'click .backup': (evt) ->
      evt.preventDefault()
      document.location.href = '/csv'

    'change .upload': (evt) ->
      evt.preventDefault()
      file = $(evt.target)[0].files[0]
      console.log file
      data = Papa.parse(file, {complete: (results, parser)->
        console.log results
        if results.errors.length > 0
          console.log 'error'
          return
        items = Item.find().fetch()
        for item in items
          Item.remove item._id
        for i in [1..results.data.length - 1]
          line = results.data[i]
          item =
            name: line[1]
            code: line[2]
            date: line[3]

            tt4: line[4]
            tt6: line[5]
            tt8: line[6]
            tt10: line[7]
            tt12: line[8]
            tt14: line[9]
            tts: line[10]
            ttm: line[11]
            ttl: line[12]
            ttxl: line[13]
            ttxxl: line[14]
            tt3xl: line[15]

            ct4: line[16]
            ct6: line[17]
            ct8: line[18]
            ct10: line[19]
            ct12: line[20]
            ct14: line[21]
            cts: line[22]
            ctm: line[23]
            ctl: line[24]
            ctxl: line[25]
            ctxxl: line[26]
            ct3xl: line[27]

            pt4: line[28]
            pt6: line[29]
            pt8: line[30]
            pt10: line[31]
            pt12: line[32]
            pt14: line[33]
            pts: line[34]
            ptm: line[35]
            ptl: line[36]
            ptxl: line[37]
            ptxxl: line[38]
            pt3xl: line[39]
          Item.insert item
      })


if (Meteor.isServer)
  Meteor.startup ->
Router.route '/', ->
  @render 'app'

Router.route '/csv',
  where: 'server'
  action: ->
    filename = "tienda#{new Date}.csv";

    headers =
      'Content-type': 'text/csv',
      'Content-Disposition': "attachment; filename=" + filename

    csv = Papa.unparse(Item.find().fetch())
    #build a CSV string. Oversimplified. You'd have to escape quotes and commas.

    @response.writeHead(200, headers);
    @response.end(csv)
