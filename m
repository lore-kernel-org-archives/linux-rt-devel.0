Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B44339719
	for <linux-rt-devel@lists.linux.dev>; Tue, 21 Jul 2026 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784639138; cv=none; b=kDwK5nNqEYUzHoIPO0cve7yMqHj4Sq0SakhFTTCzZvkVLAdMNPJMWPM3aHEi3KOpZArzK460ijtp2y7yTjyIzzD4oXKxC10B+0xLvQK5Lp0jYfNKMlUIm2dLGW85sVtEuZiHveV/BQzTXeQieQgw7TFw909ySIlNMVhWXh7GrA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784639138; c=relaxed/simple;
	bh=OLQHBJWPze5W7fKeq0Osu477INg/gknFxzSV90V2KNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oV9r8zZlwyMsdO7YivYhoBVmJDUQyU5RPyruv1FJgNQXCiligIgkbdQq/2/arncRzHr6HYs8jA1ckYLwlNY3JwsX7HM3uWEvMPRTwZHMs/+Rsr/nRwkj5HcKzziTAgUn/TErY/e7hXl5jkLcnewChbuv2QNx6s9FWB2+bNvuUlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D6vb21f2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cwB5pHuY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D6vb21f2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cwB5pHuY"
Date: Tue, 21 Jul 2026 15:05:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784639135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AvdvuJvgQzH40wE+UH4j45FMuNZHsGZtxlqnUUwKVSA=;
	b=D6vb21f2Ra3UaK/PRVw3KG5VAc40Tl3RbWcgydbaU4Dc2dhHBLWu5LXKDMdgpzI7F3+Fex
	iJuW6uYRjn8HEN4ze1ji3tbm4dq7j7DpubAUWzEqPPWUZP/RJZxYtC+Q1ZoPeKA667hjny
	pz3/Pm3Mi/j9S9jy+7Z63hAISCZgVGt7xN61P++X4chEsmkOJRWCzjMOBFuymQY6hlh5GL
	lI94lTGTMuXacQkbIgrCzo2SPStGqC34o+DwAJfeYdOpDyTbNiR0OJYmkpHlQ5gemUBK0z
	0iJdl9KNgMPxiczfl6ohIs4hCJPHwr8Sa77rNJoI6L/4rP40OdgKcceh/c4bqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784639135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AvdvuJvgQzH40wE+UH4j45FMuNZHsGZtxlqnUUwKVSA=;
	b=cwB5pHuY6WOUyC90Vcr+FYCkc59J/1u/wnsSIR+zZF37O1m08XMx8KM7/jLJNKJ6bAIPnM
	azJF9ZlSN+e88IAw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Ahmed S. Darwish" <darwi@linutronix.de>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	Matthew Wilcox <willy@infradead.org>,
	John Ogness <john.ogness@linutronix.de>,
	Derek Barbosa <debarbos@redhat.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] Documentation: real-time: Add kernel
 configuration guide
Message-ID: <20260721130533.lK7fkQSc@linutronix.de>
References: <20260716195716.256025-1-darwi@linutronix.de>
 <20260716195716.256025-2-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260716195716.256025-2-darwi@linutronix.de>

Rafael, any comments from you? Maybe on the CPU FREQ/ IDLE part?
Anything that is missing from your point of view? Here is slim version
of what we already have ;)

On 2026-07-16 21:57:14 [+0200], Ahmed S. Darwish wrote:
> new file mode 100644
> index 000000000000..99dfc73aa4d3
> --- /dev/null
> +++ b/Documentation/core-api/real-time/kernel-configuration.rst
> @@ -0,0 +1,310 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +Real-Time Kernel configuration
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +
> +.. contents:: Table of Contents
> +   :depth: 3
> +   :local:
> +
> +Introduction
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +This document lists the kernel configuration options that might affect a
> +real-time kernel's worst-case latency.  It is intended for system integr=
ators.
> +
> +Configuration options
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +``CONFIG_CPU_FREQ``
> +-------------------
> +
> +:Expectation: enabled
> +:Severity: *high*
> +
> +The CPU frequency scaling subsystem ensures that the processor can opera=
te
> +at its maximum supported frequency.  While, in general, bootloaders are
> +tasked with setting the CPU clock to the highest speed on boot, some do
> +not.  It is thus desirable to keep this option enabled.
> +
> +.. caution::
> +
> +  A real-time kernel is not about being "as fast as possible", however
> +  real-time requirements may demand that the CPU is clocked at a
> +  particular speed.
> +
> +``CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE``
> +-------------------------------------------
> +
> +:Expectation: enabled
> +:Severity: *high*
> +
> +Real-Time workloads expect a fixed CPU frequency during execution.  Using
> +the performance governor is an easy way to achieve that purely from kern=
el
> +configuration.
> +
> +This is not a blanket rule.  Some setups might prefer to clock the CPU to
> +lower speeds due to thermal packaging or other requirements.  The key is
> +that the CPU frequency remains constant once set.
> +
> +``CONFIG_CPU_IDLE``
> +-------------------
> +
> +:Expectation: enabled
> +:Severity: *info*
> +
> +CPU idle states (C-states) allow the processor to enter low-power modes
> +during periods of inactivity.  Very-low CPU idle states may require
> +flushing the CPU caches and lowering or disabling the clocking.  This can
> +lower power consumption, but it also increases the entry and exit latency
> +from such states.
> +
> +While disabling this option eliminates cpuidle-related latencies, doing =
so
> +can significantly impact hardware longevity, warranty, and thermal
> +behavior.  Users should cap the maximum C-state to C1 instead.  For ACPI
> +platforms, this can be achieved by using the boot parameter [1]_::
> +
> +  processor.max_cstate=3D1
> +
> +Higher C-states can be acceptable depending on the user workload's laten=
cy
> +requirements.  For ACPI-based platforms, use the ``cpupower idle-info``
> +command to inspect the available idle states.
> +
> +For more information, please see:
> +
> +- ``linux/tools/power/cpupower``
> +- :doc:`/admin-guide/pm/cpuidle`
> +- :doc:`/admin-guide/pm/index`
> +
=E2=80=A6
> +``CONFIG_NO_HZ`` / ``CONFIG_NO_HZ_FULL``
> +----------------------------------------
> +
> +:Expectation: disabled
> +:Severity: *medium*
> +
> +Tickless operation can increase kernel-to-userspace transition latency d=
ue
> +to the extra accounting and state book-keeping.
> +
> +*Guidance by real-time workload type:*
> +
> +- For periodic workloads; e.g., control loops executing every 100 =C2=B5=
s, avoid
> +  ``NO_HZ`` modes.  Consistent kernel ticks are preferable.
> +
> +- For computation-intensive workloads; e.g. extended userspace execution,
> +  ``NO_HZ_FULL`` may be beneficial.  In such cases, users should offload
> +  the kernel housekeeping to dedicated CPUs and isolate compute cores.
> +
> +See also :doc:`/timers/no_hz`.
> +
=E2=80=A6
> +
> +Non-performance CPU frequency governors
> +---------------------------------------
> +
> +:Expectation: disabled
> +:Severity: *medium*
> +
> +To ensure reproducible system latency measurements, disable the
> +non-``PERFORMANCE`` CPU frequency governors when possible.  This avoids =
the
> +risk of unknown userspace tasks implicitly or explicitly setting a
> +different CPU frequency governor, and thus achieving different latency
> +results across the system's runtime.
> +
> +If disabling other frequency governors is not an option, then
> +``CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE`` should be enabled.  In that ca=
se,
> +users should set a *stable* CPU frequency setting during the system
> +runtime, as changing the CPU frequency will increase the system latency =
and
> +affect latency measurements reproducibility.  If a lower CPU frequency is
> +desired, then ``CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE`` should be set.
> +
> +The ``ONDEMAND`` CPU frequency governor should *not* be enabled in a
> +real-time system since it dramatically affects determinism depending on =
the
> +workload.
> +
> +For more information, please check :doc:`/admin-guide/pm/cpufreq`.

Sebastian
