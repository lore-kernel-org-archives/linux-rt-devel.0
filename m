Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5856B3CA487;
	Tue, 15 Sep 2026 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789478811; cv=none; b=k/XiFlKaS+EQut9TO3e+aVRYrotYLQA6gaHhREsv3uTto8WDCfT8OvOmqieOMANS04yojm0ZeWJ9GvYsvSsKMRPyuqlRG9vxn+Iz4OoXpXG3Wy3hM8wXSmKlAwhH9u4BsNtjKm0u8VmjYohXXglb4ZjhDJpMdFM8JMIpys3sTh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789478811; c=relaxed/simple;
	bh=LAW/+opkb17tEgnhLmIb0sP0Lfex11T9HhnlYQp9l6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gou+xRbeFZDTV+XjzH8jDOCK3U8zlks8GOu2VCAbSHbzbx4wkkFRhBt5aqWQKte7OI/nOVCq5H0w/xUf65X/yMJqxXvpejMrfuNBttEWyv4llNMd3QBAOqU4KzlxWRT2amBkR8TqYFnYl1nGPhNoF5V8ECBiJnzvyGD4n/1I/Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=s8kEk/77; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="s8kEk/77"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DEC0515A1;
	Tue, 15 Sep 2026 06:26:44 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B76623F7B4;
	Tue, 15 Sep 2026 06:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789478808; bh=LAW/+opkb17tEgnhLmIb0sP0Lfex11T9HhnlYQp9l6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s8kEk/77TSm2d+I6O0ScM07ODaYn0VC3K+dfjQ7KgAPXepqOTspHFJY4H8P8pw8ck
	 l74zR42ErimR1aa4eAboRwQCKknTnFN8gPtmYzyK0ExCc1pbVNdC8AFOLEZqKG+iTO
	 MpPctOlfJdPnGS/O6n03PY/0jUoNQAgO0DvL+Fwo=
Date: Tue, 15 Sep 2026 14:26:45 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 1/9] coresight: etm4x: prohibit modifying ss_status
 and cntr_val while session is enabled
Message-ID: <aqlHlcPCFF1FHBHO@e129823.arm.com>
References: <20260915-separate_etm_cfg_v2-v11-0-d2b258d51747@arm.com>
 <20260915-separate_etm_cfg_v2-v11-1-d2b258d51747@arm.com>
 <20260915115115.E6B2A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260915115115.E6B2A1F000FF@smtp.kernel.org>

On Tue, Sep 15, 2026 at 11:51:15AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] coresight: NULL pointer dereference in sysfs stores during device initialization
> - [Medium] coresight: TOCTOU race in sysfs store functions bypasses session check
> --
> 
> commit e0461b6a1ca35a227d37c4654e32e424dc9d60f7
> Author: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> coresight: etm4x: prohibit modifying ss_status and cntr_val while session is enabled
> 
> This commit adds checks to prohibit modifying ss_status and cntr_val via sysfs
> while a trace session is enabled. It prevents changes to these values from
> being silently overwritten and lost when the session is disabled.
> 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > index cc6cdd3ae29d5..8d73248b840a6 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > @@ -1613,6 +1613,8 @@ static ssize_t cntr_val_store(struct device *dev,
> >  		return -EINVAL;
> >  	if (val > ETM_CNTR_MAX_VAL)
> >  		return -EINVAL;
> > +	if (coresight_get_mode(drvdata->csdev))
> 
> [Severity: High]
> Can drvdata->csdev be NULL here if this sysfs attribute is accessed during
> device initialization?
> 
> If userspace writes to this sysfs attribute immediately upon device creation
> (e.g., via udev rules), coresight_register() might not have returned yet to
> assign drvdata->csdev in etm4_probe(), leading to a NULL pointer dereference.
> 
> Could we use to_coresight_device(dev) instead to avoid this?
> 
> > +		return -EBUSY;

Vaild. theorically, It's possible but it seems enoguh to check whether
drvdata->csdev is NULL or not.

> >  
> >  	raw_spin_lock(&drvdata->spinlock);
> 
> [Severity: Medium]
> Is there a race condition here since the mode check happens before acquiring
> the spinlock?
> 
> If Thread A writes to cntr_val and passes the mode check, Thread B could
> concurrently enable the session (taking the spinlock, configuring the hardware,
> and changing the mode). Thread A would then acquire the spinlock and modify
> the software configuration, leaving it out of sync with the active hardware.
> 
> Should the mode check be moved inside the spinlock?

Not matter. anyway the etmX_enable() will set with the value when it
see. This is for preventing overwriting at the time of disable.
not the race in the enable. So it is ignorable.

> 
> >  	idx = config->cntr_idx;
> [ ... ]
> > @@ -1797,6 +1799,8 @@ static ssize_t sshot_ctrl_store(struct device *dev,
> >  
> >  	if (kstrtoul(buf, 16, &val))
> >  		return -EINVAL;
> > +	if (coresight_get_mode(drvdata->csdev))
> 
> [Severity: High]
> Does this suffer from the same NULL pointer dereference risk during device
> initialization as cntr_val_store()?
> 
> > +		return -EBUSY;
> >  
> >  	raw_spin_lock(&drvdata->spinlock);

Same above. Will add NULL check.

> 
> [Severity: Medium]
> Is this check also vulnerable to the same race condition by being outside
> the spinlock?

See above.

> 
> >  	idx = config->ss_idx;
> [ ... ]
> > @@ -1847,6 +1851,8 @@ static ssize_t sshot_pe_ctrl_store(struct device *dev,
> >  
> >  	if (kstrtoul(buf, 16, &val))
> >  		return -EINVAL;
> > +	if (coresight_get_mode(drvdata->csdev))
> 
> [Severity: High]
> Does this suffer from the same NULL pointer dereference risk during device
> initialization as cntr_val_store()?
> 
> > +		return -EBUSY;
> >  
> >  	raw_spin_lock(&drvdata->spinlock);

Same above. Will add NULL check.

> 
> [Severity: Medium]
> Is this check also vulnerable to the same race condition by being outside
> the spinlock?
> 
> >  	idx = config->ss_idx;

Ignorable.


> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260915-separate_etm_cfg_v2-v11-0-d2b258d51747@arm.com?part=1

-- 
Sincerely,
Yeoreum Yun
