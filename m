Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1065E370ACF
	for <linux-rt-devel@lists.linux.dev>; Fri, 17 Jul 2026 15:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784303936; cv=none; b=JDu8lqc2fXiQRE14WOIF61dMfEcbQdKoU+Qwju4/m0DEQd1Ioy3N6G8nNy+p7R6xzfso6No2fm+kICE3MQBXL1YMSH3RN9c2cPADwYyKUqYg8/F0CaWer60DGGyuZ4SJUcQAkhjYucNjgCiE52Nt4LiDUEAaOMdXBy1Tu5+J5Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784303936; c=relaxed/simple;
	bh=AtgJblUedqk/MGp++U2qIbkbsahrGGfYJfzRXOGEZIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SkdPggMjj9sSkpGxh/dZijuPyrMai/v/KmnzLtlUFlJvd0P1kg7oCkCX+o2fXnguTLfTIOPOwJniO9TEUx6tUpdjJPeTvAPyfSmH2PWxvD7P574VihFg4m/90hJSbwpfFazxFBZxbLz/JDKLeIJjUoF1/uRkGSsPl2WIw4tDDRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=meTzP0sb; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="meTzP0sb"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2D6C81476;
	Fri, 17 Jul 2026 08:58:47 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 013703F905;
	Fri, 17 Jul 2026 08:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784303931; bh=AtgJblUedqk/MGp++U2qIbkbsahrGGfYJfzRXOGEZIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=meTzP0sbPJwm08MUZ7+xwldKmtnHbAIhC4emfIEp/ILrACd6FgOdVUD5m4mNKs8+1
	 5ZH2KJHt1aZD5SdvtCRRvDUK5x+5rCKXDHQ8QQLtLcoUe5QFTQ1FXe6gXNcQrBKfj2
	 T8Py6kfk81fEl1iJdxoCcCByJOJUe35rdorII42U=
Date: Fri, 17 Jul 2026 16:58:48 +0100
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
Message-ID: <20260717155848.GB3998092@e132581.arm.com>
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

I agree the get_device()/put_device() pair in
coresight_cpu_get_active_path() is not a good fit for CPU PM notifier,
because the put_device() can become the final put while IRQ is disabled.

However, my understanding is this patch might cause UAF issue that the
existing code is intended to prevent.

The raw spinlock (coresight_dev_lock) serializes access to the per-CPU
csdev_source pointer. It does not guarantee the lifetime of the source
or its _parent_ device. coresight_unregister() is not only reached from
module unload; it can also be called when a driver is unbind, for
example DT overlay removal or device hotplug/unplug.

This is why the UAF issue Sashiko mentioned in patch 03 of [1]. A built
CoreSight path currently grabs references for the path components, which
keeps module alive, but that is not the same as preventing the parent
device/driver from being unbound and tearing down CoreSight device data
while an active session still has raw pointers.

There are also similar race window before the path is built: for
example etm_setup_aux() has to look up source/sink state before
coresight_build_path() establishes the path, so it might access
released source/sink data if device is unbound.

I think a proper fix needs a clearer lifetime model for an active
session. E.g., we could consider to call device_link_add() to prevent
device unbind / unregister, and unlink device when the session is
finished. Once that is in place, the CPU PM notifier can safely use the
active path without get_device()/put_device() pair anymore.

Hope this is clear and makes sense.

Thanks,
Leo

[1] https://sashiko.dev/#/patchset/20260405-arm_coresight_path_power_management_improvement-v10-0-13e94754a8be%40arm.com
