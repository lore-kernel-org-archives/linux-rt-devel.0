Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18F751A12F
	for <linux-rt-devel@lists.linux.dev>; Fri, 18 Sep 2026 17:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789751363; cv=none; b=bOwAMrSOSOwvFWl4O0qEpUphTSwI0ZB7ZKY8VIHaArUGT8WjcGCiO/FdPleaA/rguLgnWCUsPpo3/4edLAl2n2m9aV0Vjq3n9tLxMSlGMDwX9CWgDrnasf7kcwsVbdTE5+CqIG1qJQB6XxnqTNLXpv2o2Nq/ZMM/bd0akEXvvSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789751363; c=relaxed/simple;
	bh=vdOKe6Rrp4GscvqyUUGLf6JktAtcGrO8wY0beo12qEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=px5MrWH9PhFDrKWIRQfJjmK/fKTA1nI4mkn6lWSQMLNKwnzZN2Nr3pcfaVcIqcXilYlrgvUqoWCfuDrZ+XAiLpubVErH7TIeiqvS0D9REfwyetQz4OYP8k4bVPEgjVah1rLUObqvTntVwoWbAq6JD6E+ozVu4pIbTNjsiJqjpTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=CVxoj7Y3; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="CVxoj7Y3"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 73F591476;
	Fri, 18 Sep 2026 10:09:16 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 244153F7B4;
	Fri, 18 Sep 2026 10:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789751360; bh=vdOKe6Rrp4GscvqyUUGLf6JktAtcGrO8wY0beo12qEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CVxoj7Y3h8cD4voYA7Tp6aKAw/N7R2eWlk2uaHPCirSXU1Runh6Wi1MtUIZMCAdBd
	 9VSZAYx6+63JhI4QAKIgT5rOF8agppWrEdrpYU3AsFpMnL5E1QsJ0tELuPswt/1cyc
	 Qgumzx4MQbiKP/ruxzScVZlVPzTQLC2dkZAhIn7Q=
Date: Fri, 18 Sep 2026 18:09:15 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mike Leach <mike.leach@arm.com>
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, James Clark <james.clark@linaro.org>,
	Leo Yan <leo.yan@arm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH v11 4/9] coresight: etm3x: fix inconsistencies with sysfs
 configuration
Message-ID: <aq1wOxx3ibRXq5z3@e129823.arm.com>
References: <20260915-separate_etm_cfg_v2-v11-0-d2b258d51747@arm.com>
 <20260915-separate_etm_cfg_v2-v11-4-d2b258d51747@arm.com>
 <9b7086de-df87-4d5c-8a7a-fc2f7c724c0b@arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b7086de-df87-4d5c-8a7a-fc2f7c724c0b@arm.com>

> Hi,
> 
> On 9/15/26 12:34, Yeoreum Yun wrote:
> > The current ETM3x configuration via sysfs can lead to the following
> > inconsistencies:
> > 
> >    - If a configuration is modified via sysfs while a perf session is
> >      active, the running configuration may differ between before
> >      a sched-out and after a subsequent sched-in.
> > 
> > To resolve these issues, separate the configuration into:
> > 
> >    - active_config: the configuration applied to the current session
> >    - config: the configuration set via sysfs
> > 
> 
> Same comment as for the etm4 config naming

Acked.

> 
> 
> > Additionally:
> > 
> >    - Since active_config and related fields are accessed only by the local CPU
> >      in etm_enable/disable_sysfs_smp_call() (similar to perf enable/disable),
> >      remove the lock/unlock from the sysfs enable/disable path and
> >      starting/dying_cpu path except when to access config fields only.
> > 
> >    - Some of sysfs interface read etm register directly. To reduce lock
> >      scope while the etm_enable_hw()/etm_disable_hw(), handle it via
> >      IPI so that registers could be read from on proper CPU.
> > 
> > Fixes: 1925a470ce69 ("coresight: etm3x: splitting struct etm_drvdata")
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> >   drivers/hwtracing/coresight/coresight-etm.h        |  4 +-
> >   drivers/hwtracing/coresight/coresight-etm3x-core.c | 68 ++++++++++--------
> >   .../hwtracing/coresight/coresight-etm3x-sysfs.c    | 80 +++++++++++++++-------
> >   3 files changed, 100 insertions(+), 52 deletions(-)
> > 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm.h b/drivers/hwtracing/coresight/coresight-etm.h
> > index 1d753cca29439..f3796162168d4 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm.h
> > +++ b/drivers/hwtracing/coresight/coresight-etm.h
> > @@ -226,7 +226,8 @@ struct etm_config {
> >    * @etmccr:	value of register ETMCCR.
> >    * @etmccer:	value of register ETMCCER.
> >    * @traceid:	value of the current ID for this component.
> > - * @config:	structure holding configuration parameters.
> > + * @active_config:	structure holding current running configuration.
> > + * @config:	structure holding sysfs mode configuration.
> >    */
> >   struct etm_drvdata {
> >   	struct csdev_access		csa;
> > @@ -248,6 +249,7 @@ struct etm_drvdata {
> >   	u32				etmccr;
> >   	u32				etmccer;
> >   	u32				traceid;
> > +	struct etm_config		active_config;
> >   	struct etm_config		config;
> >   };
> > diff --git a/drivers/hwtracing/coresight/coresight-etm3x-core.c b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> > index 862ad0786699c..fd76a57e5f861 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm3x-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm3x-core.c
> > @@ -308,7 +308,7 @@ void etm_config_trace_mode(struct etm_config *config)
> >   static int etm_parse_event_config(struct etm_drvdata *drvdata,
> >   				  struct perf_event *event)
> >   {
> > -	struct etm_config *config = &drvdata->config;
> > +	struct etm_config *config = &drvdata->active_config;
> >   	struct perf_event_attr *attr = &event->attr;
> >   	u8 ts_level;
> > @@ -367,7 +367,7 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
> >   {
> >   	int i, rc;
> >   	u32 etmcr;
> > -	struct etm_config *config = &drvdata->config;
> > +	struct etm_config *config = &drvdata->active_config;
> >   	struct coresight_device *csdev = drvdata->csdev;
> >   	CS_UNLOCK(drvdata->csa.base);
> > @@ -442,32 +442,30 @@ static int etm_enable_hw(struct etm_drvdata *drvdata)
> >   struct etm_enable_arg {
> >   	struct etm_drvdata *drvdata;
> >   	struct coresight_path *path;
> > +	struct etm_config config;
> >   	int rc;
> >   };
> >   static void etm_enable_sysfs_smp_call(void *info)
> >   {
> >   	struct etm_enable_arg *arg = info;
> > +	struct etm_drvdata *drvdata;
> >   	struct coresight_device *csdev;
> >   	if (WARN_ON(!arg))
> >   		return;
> > -	csdev = arg->drvdata->csdev;
> > -	if (!coresight_take_mode(csdev, CS_MODE_SYSFS)) {
> > -		/* Someone is already using the tracer */
> > -		arg->rc = -EBUSY;
> > -		return;
> > -	}
> > +	drvdata = arg->drvdata;
> > +	csdev = drvdata->csdev;
> > -	arg->rc = etm_enable_hw(arg->drvdata);
> > +	drvdata->active_config = arg->config;
> > +	drvdata->traceid = arg->path->trace_id;
> > -	/* The tracer didn't start */
> > -	if (arg->rc) {
> > -		coresight_set_mode(csdev, CS_MODE_DISABLED);
> > +	arg->rc = etm_enable_hw(arg->drvdata);
> > +	if (arg->rc)
> >   		return;
> > -	}
> > +	drvdata->sticky_enable = true;
> >   	csdev->path = arg->path;
> >   }
> > @@ -512,9 +510,10 @@ static int etm_enable_sysfs(struct coresight_device *csdev, struct coresight_pat
> >   	struct etm_enable_arg arg = { };
> >   	int ret;
> > -	spin_lock(&drvdata->spinlock);
> > -
> > -	drvdata->traceid = path->trace_id;
> > +	if (!coresight_take_mode(csdev, CS_MODE_SYSFS)) {
> > +		/* Someone is already using the tracer */
> > +		return -EBUSY;
> > +	}
> >   	/*
> >   	 * Configure the ETM only if the CPU is online.  If it isn't online
> > @@ -523,23 +522,27 @@ static int etm_enable_sysfs(struct coresight_device *csdev, struct coresight_pat
> >   	if (cpu_online(drvdata->cpu)) {
> >   		arg.drvdata = drvdata;
> >   		arg.path = path;
> > +
> > +		scoped_guard(spinlock, &drvdata->spinlock) {
> > +			arg.config = drvdata->config;
> > +		}
> > +
> 
> Again I think the arg.config is unnecessary

Agree. I'll change as etm4's comment!

Thanks!

[...]


-- 
Sincerely,
Yeoreum Yun
