Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E89D22370A;
	Sat,  3 Oct 2026 01:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790992262; cv=none; b=nZhevtIbGdEhGWFktcQaPm/5mI8xdKVy/3gR+FKPzTYzvPiaha2hTmNvMKsGcAxdrt1I8SU08kr4f5xm+AnWmiSEp7aCK0NaWFZGiYZN7uxL0ZAgejIByFByTMyQg49oW0gtHrXwuPC9xkNLwuR+/XDOxHEfs3NYZ4IfLmvg4oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790992262; c=relaxed/simple;
	bh=O+JoBNf9pn4W0XdVdyqBIpEkyuUaI11FUAB6YLmKSwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQkk+8SiYnhw+uAXOQ4KecjyZljpCB7jQIL3RBlb7Jus2SxtOYv5ZBb2bxS2qou5XYm1c2VHEWO0j8XWibu7MIh4BMKxmbXr1QyAomQQJDOHdr0RwW4K2BiEY66BQO1beSOF0ImnAS98oFDZpgUx5jPww3DIWr36C6ZycVQFh34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=WEcPcKZl; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="WEcPcKZl"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8C9012F;
	Fri,  2 Oct 2026 18:50:56 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 590693F85F;
	Fri,  2 Oct 2026 18:50:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1790992259; bh=O+JoBNf9pn4W0XdVdyqBIpEkyuUaI11FUAB6YLmKSwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WEcPcKZl98DkHQ4VlesPCayAFF9cqkGIPfkMK3oTYQe+uUHlM1wRTG1+Wm3n+9qZp
	 EEAAObJsHc5BF70LPHU8vk/UqGEJLvNsjV+Vo+oxmBrUNn+R0sIV7oZ7fh3CNJKGhn
	 Oh3kjqGHin11WNbn/RbqZF7X4sMX98JtjGj1t8No=
Date: Sat, 3 Oct 2026 02:50:57 +0100
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Yeoreum Yun <yeoreum.yun@arm.com>, linux-rt-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v13 02/14] coresight: etm4x: prohibit modifying cntr_val
 while session is enabled
Message-ID: <asBfgfvZb8kmdPUl@e129823.arm.com>
References: <20261002-separate_etm_cfg_v2-v13-0-fe429d8d96fb@arm.com>
 <20261002-separate_etm_cfg_v2-v13-2-fe429d8d96fb@arm.com>
 <20261003013346.59A1E1F0089A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261003013346.59A1E1F0089A@smtp.kernel.org>

On Sat, Oct 03, 2026 at 01:33:45AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] coresight: TOCTOU race in cntr_val_store() defeats active session check
> --
> 
> commit d42ded85664acd4e853cec4a07df95780d0a17bb
> Author: Yeoreum Yun <yeoreum.yun@arm.com>
> 
> coresight: etm4x: prohibit modifying cntr_val while session is enabled
> 
> This commit adds a check to cntr_val_store() to prevent modifying the
> counter value while the coresight session is active. This prevents user
> configurations from being discarded when the session is disabled.
> 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> [ ... ]
> > @@ -1615,6 +1615,9 @@ static ssize_t cntr_val_store(struct device *dev,
> >  		return -EINVAL;
> >  	if (val > ETM_CNTR_MAX_VAL)
> >  		return -EINVAL;
> > +	if (IS_ERR_OR_NULL(drvdata->csdev) ||
> > +	    coresight_get_mode(drvdata->csdev))
> > +		return -EBUSY;
> >  
> >  	raw_spin_lock(&drvdata->spinlock);
> 
> [Severity: Medium]
> Is there a race condition here between the mode check and acquiring the
> spinlock?
> 
> If a user-space thread writes to the cntr_val sysfs file while another
> thread concurrently starts the trace session, cntr_val_store() evaluates
> coresight_get_mode() without holding drvdata->spinlock.
> 
> If the trace session is enabled immediately after this check, the hardware
> is programmed with the old configuration. The sysfs thread then acquires
> the lock and writes the new configuration. When the session is later
> disabled, the old hardware state overwrites the configuration array
> (config->cntr_val), silently losing the user's update.
> 
> Could the mode check be performed inside the drvdata->spinlock critical
> section to prevent this sequence?
> 
> >  	idx = config->cntr_idx;
> >  	config->cntr_val[idx] = val;

No, as another thread I said, This will be following patch by separating
the config and it wouldn't be expected user enabling before finishing
the configuraiton. so ignorable.

> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261002-separate_etm_cfg_v2-v13-0-fe429d8d96fb@arm.com?part=2

-- 
Sincerely,
Yeoreum Yun
