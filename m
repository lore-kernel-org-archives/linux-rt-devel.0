Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1039A51D52B
	for <linux-rt-devel@lists.linux.dev>; Fri, 18 Sep 2026 17:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789751298; cv=none; b=KftoKSvgeDKEQMqz3muZD8ANrStyI5eHzAJ5KiktuzHn1rZq4RJ7UzKKyBDllkZ2tB8UJFeAtHhLxkYU+/F5OLpBGwh0jlLlnEyDPrTuqCZjzbCMD1Vmutc45jAfpBlDy5E5je/3f7idDd7tQuS6vseV5jG1WtjkMYqY3+0tjq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789751298; c=relaxed/simple;
	bh=PY6JJUepgxCEPlcrfnMmYVpbq3oRM0GsIQdyMQ4tARA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hoyY8Xx5XUE/2kcPqaaUVJ+tNlEk/Fe+UuJ+ZWBJPzIjQtZE8de1l2smxIkRf1334KpqFhXFtrtoM5o+hTzAJ5ntqcVwW0O3svy4QQsEk/dvZSxzuZ1BtEvZosuNtelpVt8rpJfv2zBFTRSZ/We0dXfySlp2sxD75YPbX1l80fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=aN4/oV3l; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="aN4/oV3l"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC3C31476;
	Fri, 18 Sep 2026 10:08:12 -0700 (PDT)
Received: from e129823.arm.com (e129823.arm.com [10.2.213.3])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15E903F7B4;
	Fri, 18 Sep 2026 10:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789751296; bh=PY6JJUepgxCEPlcrfnMmYVpbq3oRM0GsIQdyMQ4tARA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aN4/oV3ljICWliH14xVpOIhBTcs+SMZFCDdbcHCzgm6ENRDTCMb4Jo51Olhger7Rl
	 dZdeFIq5TTL1ChBaAyhsuSJqvrK+brtiGQ0N3YGuCLmpntsdysHRXKx/9kQUwNJEYX
	 jcy3B8E2+G/GHL4Vq8IB57bFwQKZn7Q//a0XQmqA=
Date: Fri, 18 Sep 2026 18:08:11 +0100
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
	Steven Rostedt <rostedt@goodmis.org>, nd@arm.com
Subject: Re: [PATCH v11 1/9] coresight: etm4x: prohibit modifying ss_status
 and cntr_val while session is enabled
Message-ID: <aq1v-yo7gsQHasZP@e129823.arm.com>
References: <20260915-separate_etm_cfg_v2-v11-0-d2b258d51747@arm.com>
 <20260915-separate_etm_cfg_v2-v11-1-d2b258d51747@arm.com>
 <89b18b1e-65ca-4e97-b827-90d360b9e881@arm.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <89b18b1e-65ca-4e97-b827-90d360b9e881@arm.com>

Hi Mike,

> Hi,
> 
> Preventing a write to the counter value register is correct, but protecting
> the ss_status is redundant.
> 
> On 9/15/26 12:34, Yeoreum Yun wrote:
> > ss_status and cntr_val are overwritten with the values read from the
> > corresponding registers by etm4_disable_hw() when the session is disabled.
> > 
> > This means that any changes to these values made while the session is
> > enabled would be lost when the session is disabled.
> > 
> > Therefore, prohibit modifying ss_status and cntr_val while the session is
> > enabled.
> > 
> > Signed-off-by: Yeoreum Yun <yeoreum.yun@arm.com>
> > ---
> >   drivers/hwtracing/coresight/coresight-etm4x-sysfs.c | 6 ++++++
> >   1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > index cc6cdd3ae29d5..8d73248b840a6 100644
> > --- a/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > +++ b/drivers/hwtracing/coresight/coresight-etm4x-sysfs.c
> > @@ -1613,6 +1613,8 @@ static ssize_t cntr_val_store(struct device *dev,
> >   		return -EINVAL;
> >   	if (val > ETM_CNTR_MAX_VAL)
> >   		return -EINVAL;
> > +	if (coresight_get_mode(drvdata->csdev))
> > +		return -EBUSY;
> >   	raw_spin_lock(&drvdata->spinlock);
> >   	idx = config->cntr_idx;
> > @@ -1797,6 +1799,8 @@ static ssize_t sshot_ctrl_store(struct device *dev,
> >   	if (kstrtoul(buf, 16, &val))
> >   		return -EINVAL;
> > +	if (coresight_get_mode(drvdata->csdev))
> > +		return -EBUSY;
> 
> This is protecting a write clearing the STATUS bit in TRCSSCSR - but this is
> cleared automatically when next time the hardware is enabled in
> etm4_enable_hw(). So the write to ss_status in this function is redundant as
> is this protection.
> 
> The actual write to the targeted control register will persist.

Acked, I'll remove this protection in here.

Thanks!

[...]

-- 
Sincerely,
Yeoreum Yun
