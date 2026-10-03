Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59C6B31E845;
	Sat,  3 Oct 2026 02:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790992974; cv=none; b=EZd9Nk2AdgX8r3Rhm5xChJ+jKI2qej8GH5KrXdM0m3kWiyU62N6RqWGDamfROjR0/HfEDQQTDlLHnfTg9EcNMMjUgFNXUiZVENAMVaBxjUm0y2xHujmpTz9MEISnKw0XUoo4wlZ9wE6QVfG3zPLkwIc7G6C1pP7S+eS7LJDNDGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790992974; c=relaxed/simple;
	bh=v0bCbpETNJ7e5aGDatYBGDhLK4Wf9/XQ9Lj6zd6xRAk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D2yBE2vpRZHjqF5UUzwAchFg4OY3ot6Oe7BFGB2inCONwD0fUowXk/LiTeIY7IBz/NZeWhDWcL3/mSr+Io/tZiLt3AmFKDVRb3erskDGvu0XgaddSw1eVOITmtZNhwuopOWbBfHduvi/iJDMWe5Wr5FudYEig4KZy3mxCST7E08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Xcocyq/w; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Xcocyq/w"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 118532F;
	Fri,  2 Oct 2026 19:02:46 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 95CD43F85F;
	Fri,  2 Oct 2026 19:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790992969; bh=v0bCbpETNJ7e5aGDatYBGDhLK4Wf9/XQ9Lj6zd6xRAk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xcocyq/wYL+AaITh//C+S7x+SgRmYJM/Ng3YBRA3hQ37T59BBQmQpWXwY4C3ab9FJ
	 /Gng9GWrKXVTSqF8Ovf22HA+J8f1Xhtw/I/i1VryLOIC18DV7taYExJioBZNHkwATV
	 ie14zJcMHkZsrObg0CpfN/6QSNht3XCa8GPKn+lQ=
Date: Sat, 3 Oct 2026 03:02:45 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v13 03/14] coresight: etm3x: prohibit modifying cntr_val
 and reset while session is enabled
Message-ID: <asBiRRFAxGLEsSGC@e129823.arm.com>
References: <20261002-separate_etm_cfg_v2-v13-0-fe429d8d96fb@arm.com>
 <20261002-separate_etm_cfg_v2-v13-3-fe429d8d96fb@arm.com>
 <20261003013343.64B201F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261003013343.64B201F000FF@smtp.kernel.org>

> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] coresight: TOCTOU race in sysfs configuration modifications
> --
> 
> commit 58a68349c3bcb900219eaabae6561553d37341df
> Author: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> coresight: etm3x: prohibit modifying cntr_val and reset while session is enabled
> 
> This commit prevents modifying cntr_val and resetting the state when the
> trace session is enabled. It does so by checking the coresight mode before
> proceeding with modifications in sysfs store functions.
> 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> > index b3c67e96a82a4..cdb70a4382eb8 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> > @@ -75,6 +75,10 @@ static ssize_t reset_store(struct device *dev,
> >  	if (ret)
> >  		return ret;
> >  
> > +	if (IS_ERR_OR_NULL(drvdata->csdev) ||
> > +	    coresight_get_mode(drvdata->csdev))
> > +		return -EBUSY;
> > +
> >  	if (val) {
> >  		spin_lock(&drvdata->spinlock);
> 
> [Severity: High]
> Does this code introduce a TOCTOU race condition?
> 
> The coresight_get_mode() check is evaluated outside the drvdata->spinlock
> that serializes hardware and state changes.
> 
> If a concurrent thread writes to the sysfs reset attribute while another
> thread enables the trace session via enable_source, couldn't the sysfs store
> function's check pass just before the session enablement code takes the
> mode (via coresight_take_mode()) without holding the spinlock?
> 
> The sysfs store would then acquire the spinlock, clear the config, and
> release the trace ID while the session is actively building its path and
> starting up.
> 
> This could corrupt the trace configuration, allow a trace session to start
> with a zeroed-out configuration, and prematurely release the actively
> assigned trace ID, causing trace ID conflicts.
> 
> This issue was verified to remain unfixed in the final state of the patch
> series (commit 45def19b707827632be083676fa86077f5bc1585).
> 
> >  		memset(config, 0, sizeof(struct etm_config));

This is known issue and it's pre-exist one. but we don't expect
user enabling session before *reset* is returned to user.

So this is ignorable.

> 
> > @@ -744,6 +748,9 @@ static ssize_t cntr_val_store(struct device *dev,
> >  	ret = kstrtoul(buf, 16, &val);
> >  	if (ret)
> >  		return ret;
> > +	if (IS_ERR_OR_NULL(drvdata->csdev) ||
> > +	    coresight_get_mode(drvdata->csdev))
> > +		return -EBUSY;
> >  
> >  	spin_lock(&drvdata->spinlock);
> 
> [Severity: High]
> Similarly, does this safety check fail to guard concurrent updates
> to cntr_val?
> 
> The check is performed outside the spinlock, creating the same race window
> where cntr_val could be updated while the session is being enabled.
> 
> >  	config->cntr_val[config->cntr_idx] = val;

As I said another thread and the same above. also the the separation
of config will relax this problem.

-- 
Sincerely,
Yeoreum Yun
