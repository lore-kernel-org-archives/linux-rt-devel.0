Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9FC733F594
	for <linux-rt-devel@lists.linux.dev>; Tue, 21 Jul 2026 13:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784638974; cv=none; b=m2LHnCkvQK2b/sSImaX4sT6YJ0aPseAxyrTFeTGirj8XV52NFzK1K7ntrVa0tsukHGC8Rf0GSPSrsBh6Oh4YGYC/MRo7+WVtYIh8dRMgwW8WcFvz94UCjvTJsCmVHwB8GsNyye73uAUi74moebux5QXhjwd+N2o+cmUqbXHEGmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784638974; c=relaxed/simple;
	bh=sjeXmR/Z4rwlhwIQVY4on9e3k4faAXrNAG7QKTziaV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bph23iCWoSjGy8QyfJqofeSr07Qe0QLFIYVayTl8HzT7uf+g6MkQD8hX6l1YbbUhwSXfEHmL1EyzEsF7a1Ay5ASrvwlzlftsAHudYE4NiaZF3f6GXS6OQ86/oSs+JUTRY+McC777TLyTMaC6evuahm4mS+uLTFKd5AQZCIW0zqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Egt377wU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1nJJvWLp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Egt377wU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1nJJvWLp"
Date: Tue, 21 Jul 2026 15:02:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784638970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Za6PGkEODuRbJ50NfX1WZG2KsYZXVLDYi5vUBm/sq0=;
	b=Egt377wU5QX/p3ZNww43WnsDsNIfuzK9BhSmhF/2Jrbn3bXZ1Y2dfH1xGIXTKDr2lakkuY
	gpTtZyHjnIdAdpv0cVodvhch+Jq2EfRr8QSvIVC7YIs3F92ZLrMXJkCsiGN0wtWvIzqpTQ
	Vx3h7Km2DHSj9oj+6d7fQK+0rLbPsjpPT5zOc580DZIBqAZ7VLjtv69WQ0FAA0/Luxjkh7
	rfXRfmrBOlZCOneaNDWLch3SPbw2u1KO1XRMBACRZvsNgSqxYc4zEdH10cg5KDyUjr8CnH
	uUl8m1Ac9hO8MKHTAFPEBhETq6sQTXqQY96sKwS4IlLJsrX3CjzNLYALVvjjow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784638970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Za6PGkEODuRbJ50NfX1WZG2KsYZXVLDYi5vUBm/sq0=;
	b=1nJJvWLpPBH5cU3nK0pzhjz9Tixr2QS8dGQooso+MLdkiuWz7aolIQ0jKGO0E2sCWbuyAj
	VZ3uakRP0V7WAFCA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev,
	Matthew Wilcox <willy@infradead.org>,
	John Ogness <john.ogness@linutronix.de>,
	Derek Barbosa <debarbos@redhat.com>, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] Documentation: real-time: Add kernel
 configuration guide
Message-ID: <20260721130248.ndwsFtHE@linutronix.de>
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

On 2026-07-16 21:57:14 [+0200], Ahmed S. Darwish wrote:
> diff --git a/Documentation/core-api/real-time/kernel-configuration.rst b/=
Documentation/core-api/real-time/kernel-configuration.rst
> new file mode 100644
> index 000000000000..99dfc73aa4d3
> --- /dev/null
> +++ b/Documentation/core-api/real-time/kernel-configuration.rst
> @@ -0,0 +1,310 @@
=E2=80=A6
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

A dynamic governor such as CONFIG_CPU_FREQ_GOV_POWERSAVE must be
avoided.

=E2=80=A6
> +For more information, please see:
> +
> +- ``linux/tools/power/cpupower``
> +- :doc:`/admin-guide/pm/cpuidle`
> +- :doc:`/admin-guide/pm/index`
> +
> +``CONFIG_DRM``
> +--------------
> +
> +:Expectation: disabled
> +:Severity: *info*
> +
> +GPU-accelerated workloads can share system resources with the CPU,
> +including last-level cache (LLC) and memory bandwidth.  Modern integrated
> +GPUs optimize graphics performance at the expense of CPU determinism.
> +
> +Examples of affected platforms:
> +
> +- Intel processors with integrated graphics (Gen9 and later)
> +- AMD APUs with Radeon Graphics
> +- Xilinx Zynq UltraScale+ MPSoC EG/EV series
> +
> +If graphics workloads must run alongside real-time tasks, users must
> +conduct thorough stress testing using tools like ``glmark2`` while
> +measuring the overall system latency.
> +
> +For more information, please check:
> +
> +- :doc:`Regarding hardware (System memory and cache) </core-api/real-tim=
e/hardware>`
> +- :doc:`/filesystems/resctrl`

I've been told by Jonathan to avoid this and just use plain file
references such as
- Documentation/admin-guide/pm/cpuidle.rst
- Documentation/admin-guide/pm/index.rst

> +- `Real-Time and Graphics: A Contradiction?`_

And this might be included inline, too.

> +``CONFIG_TRACING`` (and tracing options)
> +----------------------------------------
> +
> +:Expectation: enabled
> +:Severity: *info*
> +
> +Shipping kernels with tracing support enabled (but not actively running)=
 is
> +highly recommended.  This will allow the users to extract more informati=
on
> +if latency problems arise.  Nonetheless, some tracers do incur latency
> +overhead by just being enabled; see :ref:`tracers`.

Instead of this jumping forth and back while reading, couldn't the
CONFIG_IRQSOFF_TRACER and CONFIG_PREEMPT_TRACER be added here?

> +.. caution::
> +
> +  Users should *not* make use of tracers or trace events during producti=
on
> +  real-time kernel operation as they can add considerable overhead and
> +  degrade the system's latency.
>
> +Non-performance CPU frequency governors
> +---------------------------------------

so here it is.

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

Could we please merge this in the previous section so that we don't have
two times the CPU frequency governors.

> +Kernel Debug Options
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +Most kernel debug options add runtime overhead that increases the
> +worst-case latency.
> +
> +.. caution::
> +
> +  During development and early testing, users are encouraged to run their
> +  real-time workloads and peripherals with lockdep (:ref:`lockdep`) and
> +  other kernel debug options enabled, for a considerable amount of time.
> +  Such workloads might trigger kernel code paths that were not triggered
> +  during the internal Linux real-time kernel development, thus helping to
> +  uncover locking and other types of kernel bugs.
> +
> +Problematic debug options
> +-------------------------
=E2=80=A6
> +``CONFIG_PROVE_LOCKING``
> +^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Severity: *high*
> +
> +Proving the correctness of all kernel locking adds substantial overhead
> +and significantly increases worst-case latency.

Could we merge the caution box from before here somehow? The statement
is that lockdep is very helpful in validating lockchains and so on
especially on paths which are only seen if the real-time workload is
active. However, since it can easily introduce scheduling latencies of
10ms it is hardly an option that ca be enabled in production.

> +Allowed kernel debug options
> +----------------------------
> +
> +Kernel debug options which are not included in this list should be enabl=
ed
> +with caution, after extensive auditing of their impact on system latency.
> +
> +``CONFIG_DEBUG_ATOMIC_SLEEP``
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +This sanity check catches common kernel programming errors with
> +a tolerable latency cost.

It also increases scheduling since each might_sleep() can lead to
context switch.

> +
> +``CONFIG_DEBUG_BUGVERBOSE``
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +This improves the debugging capabilities without affecting normal
> +operation latency.
> +
> +``CONFIG_DEBUG_FS``
> +^^^^^^^^^^^^^^^^^^^
> +
> +This is safe to include in real-time kernels, *provided that debugfs is
> +not accessed during production runtime*.

It is safe to have as long as you don't use it.

I would drop it. That filesystem is not dangerous on its own. It depends
on the options you change and how this affect the system.
We used to have it always enabled because you needed it for tracing.
This is no longer the case as it has its own tracefs which has its own
live outside of debugfs. So I don't think it is needed to mention it.

> +``CONFIG_DEBUG_INFO``
> +^^^^^^^^^^^^^^^^^^^^^
> +
> +This increases the kernel image size but has no latency impact.  It is
> +also essential for meaningful crash dumps and profiling.

This is also the case for CONFIG_DEBUG_BUGVERBOSE. However this option
can't be selected on its own. It is selected by other options such as
DEBUG_INFO_REDUCED or if you select the compression method of it.

> +
> +``CONFIG_DEBUG_KERNEL``
> +^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Meta-option which allows debug features to be enabled.  This configurati=
on
> +option has no runtime impact, but be aware of any debug features that it
> +may have allowed to be enabled.

This one should come first (if at all) because it enables to access of
few of the options mentioned in this section.

> +Summary
> +=3D=3D=3D=3D=3D=3D=3D
> +
> +There is no "one size fits all" solution for configuring a real-time Lin=
ux
> +system.  Beginning with the system real-time requirements, integrators
> +must consider the features and functions of the system's hardware, kerne=
l,
> +and userspace.  All such components must be properly configured in order
> +to establish and constrain the system's maximum latency.
> +
> +With that in mind, any incorrect real-time kernel configuration could ca=
use
> +a new maximum latency that shows up at the wrong time and is catastrophic
> +for the real-time system's latency.

Basically everything could be turned on during testing but later it must
go. Certain things like CONFIG_DEBUG_LIST are probably good have but
others, such as those you mentioned, need to go in order to have a
usable system.

Sebastian
