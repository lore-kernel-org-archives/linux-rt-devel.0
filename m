Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 834833EE1C5
	for <linux-rt-devel@lists.linux.dev>; Fri, 17 Jul 2026 10:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784285345; cv=none; b=grjK13kdkOgbn7CwjCEwq/37AEvz4ByPGVdNwnAxf2E+QQE5bIbZbr2bj8a960gK+EHgLB+u70YJ9h7VNogPnzRvGxJIyqo+4knM20cFEpxQnCUp8y9HwBLIkUl2qOIZ1PsCIcYZhQb9PgRd6pI1ntQbfejKAyskrhZo/Jdn2qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784285345; c=relaxed/simple;
	bh=cxn8Lsn3d4qePsulTs4i5GyggLvnEEsEUWj0jhm1nk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqzBY4inr3K/SXsHnPJ9vN+C0vnDqaDUlbilq4ahSfnQ6PjX03QZxBGg07Aq+XctvNeJCj4phqb2sYL4Xo+X7/1gooQOGBjvwGe5v6KkcvSXEyeT8Ko+vbEIFctTSdBfOwKEQWiuxEJlc/7RbKfMPrhwYjoCUTUQaCD8ddc5ZGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=vgp1fR29; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="vgp1fR29"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C16A61476;
	Fri, 17 Jul 2026 03:48:58 -0700 (PDT)
Received: from localhost (unknown [10.2.196.114])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7A01F3F7D8;
	Fri, 17 Jul 2026 03:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784285342; bh=cxn8Lsn3d4qePsulTs4i5GyggLvnEEsEUWj0jhm1nk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vgp1fR29s+j3ynvwGZVFscWPT3WAh2dHTtjsQX/0bF5/dCExwMImZV3mR26InoRfd
	 n7yQ/C7FisXOKK1rJpXcxoDo8vMmlLqrQPciVBK18Pqpnhl7heHFlIA7Q+4tyDWPUB
	 arxhrqh+zubBqJ4Qk6E6GeVoranTyZRiI2SMi+h4=
Date: Fri, 17 Jul 2026 11:49:00 +0100
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
Message-ID: <20260717104900.GA3998092@e132581.arm.com>
References: <20260712210446.14290-1-mohamedaymanworkspace@gmail.com>
 <20260716214155.2049564-1-mohamedaymanworkspace@gmail.com>
 <20260717081453.pSDTUQQW@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260717081453.pSDTUQQW@linutronix.de>

Hi Mohamed & Sebastian,

On Fri, Jul 17, 2026 at 10:14:53AM +0200, Sebastian Andrzej Siewior wrote:

[...]

> There is coresight_put_percpu_source_ref() with holds coresight_dev_lock
> during a put_cpu. I don't know why the lock is held, it is not obvious
> to me. But it will lead to a similar problem if the put actually invokes
> the release callback.

Sorry I am a bit late to join the discussion.

Essentially, this is about how to manage a module's lifetime correctly
so that the CPU PM notifier can safely access a device. There is an edge
case where the CPU PM notifier is accessing the device while, at the
same time, the module is being unloaded and the device's resources are
being released.

For now, I'd suggest please hold on this patch. Give me a bit time to
study this thread, I will share back more details.

Thanks,
Leo
