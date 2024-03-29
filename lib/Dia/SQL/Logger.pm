package Dia::SQL::Logger;

# $Id: Logger.pm 446 2009-02-20 11:46:14Z aff $

use warnings;
use strict;

use Log::Log4perl;
use Log::Dispatch::FileRotate;

=head2 new

The constructor.  Arguments:

=cut

sub new {
  my ( $class, %param ) = @_;

  my $self = {
    log         => undef,
  };

  bless( $self, $class );

  $self->_init_log();
  return $self;
}

=item _init_log

Initialize the logger.  The commented lines are deliberately left to
serve as exmples.

=cut 

sub _init_log {
  my $self = shift;

  # Init logging
  my $conf = q(
    # Main logger for Dia::SQL
#    log4perl.category.Dia::SQL        = INFO, file, screen-main
#    log4perl.category.Dia::SQL        = DEBUG, file, screen-main
#    log4perl.category.Dia::SQL        = WARN, screen-main
#    log4perl.category.Dia::SQL        = DEBUG, screen-main
    log4perl.category.Dia::SQL        = INFO, screen-main
    log4perl.appender.screen-main         = Log::Log4perl::Appender::Screen
    log4perl.appender.screen-main.stderr  = 1
    log4perl.appender.screen-main.layout  = PatternLayout
    log4perl.appender.screen-main.layout.ConversionPattern=[%p] %F %L %M %m%n 

    log4perl.appender.file           = Log::Dispatch::FileRotate
    log4perl.appender.file.filename  = dia-sql.log
    log4perl.appender.file.mode      = append
    log4perl.appender.file.size      = 100000
    log4perl.appender.file.max       = 5
    log4perl.appender.file.layout    = PatternLayout
    log4perl.appender.file.layout.ConversionPattern=[%p] %d %F:%L: %m%n


    # Separate logger for Output::*
#    log4perl.category.Dia::SQL::Output  = DEBUG, screen-output
    log4perl.category.Dia::SQL::Output  = INFO, screen-output
    log4perl.appender.screen-output            = Log::Log4perl::Appender::Screen
    log4perl.appender.screen-output.stderr     = 1
    log4perl.appender.screen-output.layout     = PatternLayout
    log4perl.appender.screen-output.layout.ConversionPattern=[%p] %F %L %M %m%n 
    log4perl.additivity.Dia::SQL::Output  = 0

    # Separate logger for Utils.pm
#    log4perl.category.Dia::SQL::Utils  = DEBUG, screen-utils
    log4perl.category.Dia::SQL::Utils  = INFO, screen-utils
    log4perl.appender.screen-utils            = Log::Log4perl::Appender::Screen
    log4perl.appender.screen-utils.stderr     = 1
    log4perl.appender.screen-utils.layout     = PatternLayout
    log4perl.appender.screen-utils.layout.ConversionPattern=[%p] %F %L %M %m%n 
    log4perl.additivity.Dia::SQL::Utils  = 0

  );

  Log::Log4perl::init( \$conf );
  return 1;
}

=head2 get_logger

  Return logger singleton object.

=cut

sub get_logger {
    my ($self, $name) = @_;
    #return $self->{logger};
    return Log::Log4perl::->get_logger($name);
}


=head2 log_off

Decrease log level on all appenders.
    
=cut

sub log_off {
  my $self = shift;

  $self->_init_log() unless Log::Log4perl->initialized();

  Log::Log4perl->appender_thresholds_adjust(7);

  return 1;
}

=head2 log_on

Increase log level on all appenders.
    
=cut

sub log_on {
  my $self = shift;

  $self->_init_log() unless Log::Log4perl->initialized();

  Log::Log4perl->appender_thresholds_adjust(-7);

  return 1;
}


1;

__END__

# End of Dia::SQL::Logger


=pod

=head1 SEE ALSO

  Log::Logperl

Make appender_thresholds_adjust return number of appenders changed:

  https://rt.cpan.org/Ticket/Display.html?id=43426

=cut

