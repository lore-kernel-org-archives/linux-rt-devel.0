Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F8A14DD6E0
	for <linux-rt-devel@lists.linux.dev>; Tue, 21 Jul 2026 15:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784647286; cv=none; b=dQRjHo7WmAqkY/21dOZ8X0B0VOoaoczVaOYswEFJ6fYoFDtKzXTbWtJrKsYgL6Qgh6NYzn7tAgY/nBZKFE+gzuPgvqk4J5oWiMQNc2K2nkwtfsK6Gz5H33Yfx8NkZLxVojPQbuCa/AJdd2hHID/Gj8eryygrDxVvAGcYy7++REk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784647286; c=relaxed/simple;
	bh=8tIZqKZC5uligLhDlUDw2ljDTmMQ/3tQL4faHidSgVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BvOHz9EdPazmxXoV5vT0DziyexcUc04ZT7WY3ClLpFOOZLrrnLaq/phrRyD7iEAi0llCLtRFaMbmuTXFm6+lRnP5bnCfAsWPZjPQRjtoft5V85oJARRB9qsi5RYZr+iUX1XIrdbX1cTFUTQhDEiXjL9yUviPBtkJFQ+oqTJGiFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VZtsWhbB; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VZtsWhbB"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C8E76152B;
	Tue, 21 Jul 2026 08:21:19 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 92F7C3F58B;
	Tue, 21 Jul 2026 08:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784647284; bh=8tIZqKZC5uligLhDlUDw2ljDTmMQ/3tQL4faHidSgVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VZtsWhbBV5+/vbr/nOiCEbiiH4MAYY1Ktg6JfACAVTBu7NRgvKKuEdYYh8nfprVmA
	 Nit5bbvaZ7YN86uI/XeQiS9BH8bJj7zxNFRg1oGtst/OFWo2TDlm7QL9TskeZpvCsr
	 4A5ml24A5JrulZSbsrcfjmdpMkHjEqLm6vGfEw1Y=
Date: Tue, 21 Jul 2026 16:21:21 +0100
From: Leo Yan <leo.yan@arm.com>
To: Mohamed Ayman <mohamedaymanworkspace@gmail.com>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"moderated list:ARM/CORESIGHT FRAMEWORK AND DRIVERS" <coresight@lists.linaro.org>,
	"moderated list:ARM/CORESIGHT FRAMEWORK AND DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH v3] coresight: Fix scheduling while atomic in
 coresight_cpu_pm_notify()
Message-ID: <20260721152121.GM3998092@e132581.arm.com>
References: <20260712210446.14290-1-mohamedaymanworkspace@gmail.com>
 <20260716214155.2049564-1-mohamedaymanworkspace@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260716214155.2049564-1-mohamedaymanworkspace@gmail.com>

On Fri, Jul 17, 2026 at 12:41:54AM +0300, Mohamed Ayman wrote:

[...]

>  static struct coresight_path *coresight_cpu_get_active_path(enum cs_mode mode)
>  {
>  	struct coresight_device *source;
> -	bool is_active = false;
> +	struct coresight_path *path = NULL;
>  
> -	source = coresight_get_percpu_source_ref(smp_processor_id());
> -	if (!source)
> -		return NULL;
> -
> -	if (coresight_get_mode(source) & mode)
> -		is_active = true;
> +	guard(raw_spinlock_irqsave)(&coresight_dev_lock);
>  
> -	coresight_put_percpu_source_ref(source);
> +	source = per_cpu(csdev_source, smp_processor_id());
> +	if (source && (coresight_get_mode(source) & mode))
> +		path = source->path;
>  
> -	/*
> -	 * It is expected to run in atomic context or with the CPU lock held for
> -	 * sysfs mode, so it cannot be preempted to disable the path. Here
> -	 * returns the active path pointer without concern that its state may
> -	 * change. Since the build path has taken a reference on the component,
> -	 * the path can be safely used by the caller.
> -	 */

Please keep the comment, as it helps explain why the path pointer can be
returned and safely used by the caller.

> -	return is_active ? source->path : NULL;
> +	return path;

With above update:

Reviewed-by: Leo Yan <leo.yan@arm.com>

Just a thought: we could view this in two stages.

1) The first stage is building the CoreSight path, where we need to
   ensure the involved modules remain bound while the path is being
   established.

2) Once the path has been built and the device mode is enabled, we
   enter the runtime stage. From that point on, observing the device
   mode as enabled guarantees that the associated data structures
   can be accessed safely.

I would leave this to maintainers for a call in case any concerns on
lifetime management.
