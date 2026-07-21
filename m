Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA0F4CA275
	for <linux-rt-devel@lists.linux.dev>; Tue, 21 Jul 2026 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784645857; cv=none; b=FN6KTcSwnS9Shmu7NCNUZYNkBXcaLfbojb9Dj1gsOdCyIRUBP179SJmVMj+cpMR1JD1osML21xrQU1TDMNDzOnbSMaACT4LUd53c3a57mbHiyXjjZawqGcKAdryJsrG/JFK67O6g/tcvxu+uSNQbasQiR3OGW4LpJaNEAR+OlWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784645857; c=relaxed/simple;
	bh=4qtcIpB1P2IKiXD+CcVbmvM7uLJl/Gi8tdxbWcGhvKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cCLF40zQ9mpQoLb/hO+WTF+4NQX3KEP33aau0xhmBqH3cpngAosnJ5vAvqwNFOMJJL8YbZqTJw2RfPQQrPPnKXHRHzemHc9mTZWOEu7WasWsslnQGKrVl6NhgelZqS22T+8/AJ0TgNvmIqaoq13Wepijmjjt5fVXgq3igrgUm+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=tQ3zhhOG; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="tQ3zhhOG"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E80F152B;
	Tue, 21 Jul 2026 07:57:30 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00D103F86F;
	Tue, 21 Jul 2026 07:57:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784645854; bh=4qtcIpB1P2IKiXD+CcVbmvM7uLJl/Gi8tdxbWcGhvKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tQ3zhhOGd04WqDEMkb7LkLTFKTpvSjf/61W3T8jfJiBAWr8jcCIUZPx7o95EX4TY3
	 Hcf6NQAwOExBTigWC0GYX7QIWz/jsmkYDtTZD+Ji3bLeSwKikWO7MYtrhInuTYnwAj
	 6bWHwe29vJ12HpiM1m9cEgrPDKGOF6k0C5VAVqZ0=
Date: Tue, 21 Jul 2026 15:57:32 +0100
From: Leo Yan <leo.yan@arm.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Mohamed Ayman <mohamedaymanworkspace@gmail.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Mike Leach <mike.leach@arm.com>,
	James Clark <james.clark@linaro.org>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	"moderated list:ARM/CORESIGHT FRAMEWORK AND DRIVERS" <coresight@lists.linaro.org>,
	"moderated list:ARM/CORESIGHT FRAMEWORK AND DRIVERS" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH v3] coresight: Fix scheduling while atomic in
 coresight_cpu_pm_notify()
Message-ID: <20260721145732.GL3998092@e132581.arm.com>
References: <20260712210446.14290-1-mohamedaymanworkspace@gmail.com>
 <20260716214155.2049564-1-mohamedaymanworkspace@gmail.com>
 <20260717155848.GB3998092@e132581.arm.com>
 <20260717161201.3jkO5o71@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717161201.3jkO5o71@linutronix.de>

On Fri, Jul 17, 2026 at 06:12:01PM +0200, Sebastian Andrzej Siewior wrote:

[...]

> > The raw spinlock (coresight_dev_lock) serializes access to the per-CPU
> > csdev_source pointer. It does not guarantee the lifetime of the source
> > or its _parent_ device. coresight_unregister() is not only reached from
> > module unload; it can also be called when a driver is unbind, for
> > example DT overlay removal or device hotplug/unplug.
> 
> But doesn't coresight_unregister() block on the coresight_dev_lock here?

Fair point.

coresight_cpu_get_active_path() can safely access the source while
holding coresight_dev_lock. Unregistration will be blocked until the
access from the CPU PM notifier has finished.

> > I think a proper fix needs a clearer lifetime model for an active
> > session. E.g., we could consider to call device_link_add() to prevent
> > device unbind / unregister, and unlink device when the session is
> > finished. Once that is in place, the CPU PM notifier can safely use the
> > active path without get_device()/put_device() pair anymore.
> 
> Right. I am also not sure about lifetime of coresight_device::path.

coresight_device::path is a runtime pointer that is valid only while
the device is enabled.

Since both the path and the device mode are updated atomically on the
local CPU, observing the device mode as enabled guarantees that the
corresponding coresight_device::path is valid.

Thanks,
Leo
