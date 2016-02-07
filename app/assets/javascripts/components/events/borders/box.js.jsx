var MlborderEventBorderBox = React.createClass({
  getInitialState : function() {
    return {data: []};
  },
  render: function() {
    var chartBox;
    if(this.isBorderLoaded()) {
      chartBox = <div id="chartdiv" />;
    } else {
      chartBox = (
        <div id="chartdiv" className="text-center" style={this.style.borderSummary}>
          <i className="fa fa-spin fa-spinner"></i>
          Loading...
        </div>
      );
    }

    return (
      <div className='row'>
        <div className='col-md-9'>
          {chartBox}
        </div>
        <div className='col-md-3'>
          <div className='row' style={this.style.borderSummary}>
            <MlborderEventBorderBoxSummary time={this.props.border_summary.time} data={this.props.border_summary.borders} />
          </div>
          <div className='row'>
            <div className='col-md-12'>
              <div id="legenddiv" style={this.style.legendDiv}></div>
            </div>
          </div>
        </div>
      </div>
    );
  },
  componentDidMount : function() {
    this.loadBorder();
  },
  componentDidUpdate : function () {
    if(this.isBorderLoaded()) {
      window.createAmCharts('chartdiv', 'legenddiv', this.state.data);
    } else {
      this.loadBorder();
    }
  },
  style: {
    borderSummary: {
      marginTop: "1.5em"
    },
    legendDiv: {
      maxWidth: "240px"
    }
  },
  isBorderLoaded : function () {
    return (this.state.data.length > 0);
  },
  loadBorder : function () {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      cache: false,
      success: function(data) {
        this.setState({data: data});
      }.bind(this),
      error: function(xhr, status, err) {
        console.error(status, err.toString());
      }.bind(this)
    });
  },
});

var MlborderEventBorderBoxSummary = React.createClass({
  render: function() {
    var recent = new Date(this.props.time);
    var adjustedDate = new Date(recent.getTime() - (recent.getTimezoneOffset() * 60000));
    var timeString = (
      adjustedDate.getUTCFullYear() + '/'
      + ('00' + String(adjustedDate.getUTCMonth() + 1)).substr(-2) + '/'
      + ('00' + String(adjustedDate.getUTCDate())).substr(-2) + ' '
      + ('00' + String(adjustedDate.getUTCHours())).substr(-2) + ':'
      + ('00' + String(adjustedDate.getUTCMinutes())).substr(-2)
    );

    var borderList = Object.keys(this.props.data).map(function(rank) {
      return <MlborderEventBorderBoxSummaryData key={rank} rank={rank} point={this.props.data[rank]} />
    }, this);

    return (
      <div className='col-md-12'>
        <div className="panel panel-default">
          <div className="panel-heading">
            {timeString}時点
          </div>
          <table className='table'>
            <tbody>
              {borderList}
            </tbody>
          </table>
        </div>
      </div>
    );
  }
});

var MlborderEventBorderBoxSummaryData = React.createClass({
  render: function() {
    var pointWithDelimiter = this.props.point.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");

    return (
      <tr>
        <th className='text-right'>{this.props.rank}位:</th>
        <td>{pointWithDelimiter}pt</td>
      </tr>
    );
  }
});