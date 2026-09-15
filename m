Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 442CF3B14D6;
	Tue, 15 Sep 2026 13:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789479012; cv=none; b=u+IIG/NTlyp/NIW4vqbj2Xf3+eP2rfavLPAmREKKcmaM/0JZrZIpGWxLuKaBhtaa9dIjiT/b3drQ3pePL4/9Njaf/VlVMpioSLGphWXFXv+v5Z4bjO3a4e55B4GfkBOfTBfog0clQINdvMbPM0Svca/5LfdSUzTHdRWKyrhdB0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789479012; c=relaxed/simple;
	bh=pUMdwBaUhJX8d1gHyLTTcvDeEXHvZcyE1FodWuvhRZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IbNBs/nfhbZxKqcsSgB5gfx9qGnRfP9Sx81OMo+hU27zkXzOaBEQmrZiaXnBWKYa6yaK8P/K+kyyZvP3FtW2VP9Rt3q+gRFTkKbZev75Gub1i27TM4vBMsjkS6W8fRF1wFOK9eY/CeouteGmGpzM9ppu7MAwGbv8Fk9jWt/4y4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=m8+m84wa; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="m8+m84wa"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3AD8915A1;
	Tue, 15 Sep 2026 06:30:06 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2F8463F7B4;
	Tue, 15 Sep 2026 06:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789479009; bh=pUMdwBaUhJX8d1gHyLTTcvDeEXHvZcyE1FodWuvhRZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m8+m84waG523xweVwbBzZrU9XQz8UvhYF6SMam6oEgpSutJKYhl7yxdKS0qr89RSR
	 u+U1FGsaroPhL15m9Qd0WB/aaWVO16Aiq0oZULqefwRE7iXLm5NVokVOPpoerGNIFb
	 NtDcDUmmMFc1CByQ8WOzUQTEyqowD4lK9anho2Xc=
Date: Tue, 15 Sep 2026 14:30:06 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v11 2/9] coresight: etm3x: prohibit modifying cntr_val
 and reset while session is enabled
Message-ID: <aqlIXrqCCkpNmv6y@e129823.arm.com>
References: <20260915-separate_etm_cfg_v2-v11-0-d2b258d51747@arm.com>
 <20260915-separate_etm_cfg_v2-v11-2-d2b258d51747@arm.com>
 <20260915114845.CFA601F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915114845.CFA601F000FF@smtp.kernel.org>

On Tue, Sep 15, 2026 at 11:48:44AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] coresight: TOCTOU race in sysfs configuration store functions
> --
> 
> commit 9a331a4cd5a9fd51e7380e92ed6bdd6d8e20d5e4
> Author: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> coresight: etm3x: prohibit modifying cntr_val and reset while session is enabled
> 
> This commit attempts to prevent modifications to cntr_val and reset while
> a CoreSight trace session is enabled. It adds a check for the current
> mode using coresight_get_mode() before proceeding with the sysfs store
> operations.
> 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> > --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> > @@ -74,6 +74,8 @@ static ssize_t reset_store(struct device *dev,
> >  	ret = kstrtoul(buf, 16, &val);
> >  	if (ret)
> >  		return ret;
> > +	if (coresight_get_mode(drvdata->csdev))
> > +		return -EBUSY;
> >  
> >  	if (val) {
> >  		spin_lock(&drvdata->spinlock);
> 
> [Severity: Medium]
> Could this lockless check introduce a time-of-check to time-of-use race?
> 
> If a concurrent thread starts a trace session via the enable_source sysfs
> file right after coresight_get_mode() returns false, it might win the race
> before spin_lock() is acquired here.
> 
> This could result in resetting the configuration of an active trace session
> and erroneously releasing its trace ID, potentially leading to trace ID
> collisions and hardware trace stream corruption.
> 
> [ ... ]
> 
> > @@ -744,6 +746,8 @@ static ssize_t cntr_val_store(struct device *dev,
> >  	ret = kstrtoul(buf, 16, &val);
> >  	if (ret)
> >  		return ret;
> > +	if (coresight_get_mode(drvdata->csdev))
> > +		return -EBUSY;
> >  
> >  	spin_lock(&drvdata->spinlock);
> 
> [Severity: Medium]
> Is this susceptible to a similar race condition as reset_store?
> 
> Since coresight_get_mode() is checked outside the spinlock, a concurrent
> thread could enable the session just before spin_lock() is acquired,
> allowing the counter value to be modified while the session is active.

Anyway, the reset interface is nausty. but yeap it would be better to
check after grabbing *lock*  in here.

-- 
Sincerely,
Yeoreum Yun
