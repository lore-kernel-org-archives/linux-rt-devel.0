Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906E64A263F;
	Tue, 15 Sep 2026 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789480559; cv=none; b=BD9YlfDFwxearguBTs5XdbKP1O/jLYQqq1ZclP3CJYwMHVCiSEdArQ+Pj+heHZUijYVX1/xUIg5Wl9Pq018c5Gs6+PXOy2ILUpfhuYRmXSxDZMU0OGv94tAcLp7obZCMviuLVphlktPfVLSO5Lua9BtoPYOzAreWeUndX5+f4/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789480559; c=relaxed/simple;
	bh=22VdWAtHPIAzlrnKp7utmfDAoVYxyCCYJOO5EOr8ej4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RDNGqbMQa9+t8jOf//j4YhpwLHobdn+xPEIs6BqcdI2uA2vvcQEJjXIYWL7on5JYYXe8hxDCv5XLpsu4QvVAkaU9ZbnbMFehxVAXMdwImVRcvhhbd+FRqdGccHdnC54VAB7rZinbIKJHqMwCjs9MeMZY+J6kSiAKNta3pKHiDkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FZLPx5Pv; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FZLPx5Pv"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 215A515A1;
	Tue, 15 Sep 2026 06:55:52 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ED53C3F7B4;
	Tue, 15 Sep 2026 06:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789480555; bh=22VdWAtHPIAzlrnKp7utmfDAoVYxyCCYJOO5EOr8ej4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FZLPx5Pv6BiK66qfwlEXpBI5sH/r7TDKHp69TWUdZ6TgeXwiGLJILxWhMkVrxowt3
	 lnnrjP4cciK3wImId9RfGrpRgNUDoPfhAPk/Vl34jeb+DIDmHRzCimgIjwVpOmVlSR
	 DdFhzM79qSGC4pgEe3uEaQ6j4vRpp5XNrxQfs0CI=
Date: Tue, 15 Sep 2026 14:55:52 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v11 2/9] coresight: etm3x: prohibit modifying cntr_val
 and reset while session is enabled
Message-ID: <aqlOaAUneO1xso7R@e129823.arm.com>
References: <20260915-separate_etm_cfg_v2-v11-0-d2b258d51747@arm.com>
 <20260915-separate_etm_cfg_v2-v11-2-d2b258d51747@arm.com>
 <20260915114845.CFA601F000FF@smtp.kernel.org>
 <aqlIXrqCCkpNmv6y@e129823.arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqlIXrqCCkpNmv6y@e129823.arm.com>

On Tue, Sep 15, 2026 at 02:30:06PM +0100, Yeoreum Yun wrote:
> On Tue, Sep 15, 2026 at 11:48:44AM +0000, sashiko-bot@kernel.org wrote:
> > Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> > - [Medium] coresight: TOCTOU race in sysfs configuration store functions
> > --
> > 
> > commit 9a331a4cd5a9fd51e7380e92ed6bdd6d8e20d5e4
> > Author: Yeoreum Yun <yeoreum.yun@arm.com>
> > 
> > coresight: etm3x: prohibit modifying cntr_val and reset while session is enabled
> > 
> > This commit attempts to prevent modifications to cntr_val and reset while
> > a CoreSight trace session is enabled. It adds a check for the current
> > mode using coresight_get_mode() before proceeding with the sysfs store
> > operations.
> > 
> > > diff --git a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> > > --- a/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> > > +++ b/drivers/hwtracing/coresight/coresight-etm3x-sysfs.c
> > > @@ -74,6 +74,8 @@ static ssize_t reset_store(struct device *dev,
> > >  	ret = kstrtoul(buf, 16, &val);
> > >  	if (ret)
> > >  		return ret;
> > > +	if (coresight_get_mode(drvdata->csdev))
> > > +		return -EBUSY;
> > >  
> > >  	if (val) {
> > >  		spin_lock(&drvdata->spinlock);
> > 
> > [Severity: Medium]
> > Could this lockless check introduce a time-of-check to time-of-use race?
> > 
> > If a concurrent thread starts a trace session via the enable_source sysfs
> > file right after coresight_get_mode() returns false, it might win the race
> > before spin_lock() is acquired here.
> > 
> > This could result in resetting the configuration of an active trace session
> > and erroneously releasing its trace ID, potentially leading to trace ID
> > collisions and hardware trace stream corruption.
> > 
> > [ ... ]
> > 
> > > @@ -744,6 +746,8 @@ static ssize_t cntr_val_store(struct device *dev,
> > >  	ret = kstrtoul(buf, 16, &val);
> > >  	if (ret)
> > >  		return ret;
> > > +	if (coresight_get_mode(drvdata->csdev))
> > > +		return -EBUSY;
> > >  
> > >  	spin_lock(&drvdata->spinlock);
> > 
> > [Severity: Medium]
> > Is this susceptible to a similar race condition as reset_store?
> > 
> > Since coresight_get_mode() is checked outside the spinlock, a concurrent
> > thread could enable the session just before spin_lock() is acquired,
> > allowing the counter value to be modified while the session is active.
> 
> Anyway, the reset interface is nausty. but yeap it would be better to
> check after grabbing *lock*  in here.

But, later patch seperates the config. So it could be ignored.

-- 
Sincerely,
Yeoreum Yun
