Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32556364E8C
	for <linux-rt-devel@lists.linux.dev>; Thu,  5 Mar 2026 23:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772752067; cv=none; b=jn78rvuBF87NHMVoR3T6vJH3DHn0awE1Vc01NMNzPmPumM0YzammrDHSq1AnfNJjM2Ayn1bx5tMw1peEEJUuZyqtzDoCrJsj6iKKoRszV+v/r+bRpgtp5GJIxeeNlU8hG7WFUQ4eznT2QxzIEEBuzREX/3mfRs5+PG3lAqTzP8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772752067; c=relaxed/simple;
	bh=6vkn9RGfycYWW3Rnndysdl2DVF6yOew9y7fmGirUJf4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZqh2OCXoABoPQpDVaoS6yfmHCOUy4/0dnkLgBj+l6gdC2DOXR6s4Q1J3XW0vN27wS1w0tscLS7tRRbs0vOEp+TQeXLj5YdZ4YgxoGAA00XISExT9Zae7uYlT7Q9Sgipz8MSAJQoqvNUWUCOegNQ5Uafx73L7fgOEoGTC7Cvlu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf20.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id BFC83B71F1;
	Thu,  5 Mar 2026 23:07:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf20.hostedemail.com (Postfix) with ESMTPA id AEB9B20025;
	Thu,  5 Mar 2026 23:07:42 +0000 (UTC)
Date: Thu, 5 Mar 2026 18:07:41 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Clark Williams <clrkwllms@kernel.org>,
 linux-rt-devel@lists.linux.dev, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, John Ogness <john.ogness@linutronix.de>, Derek
 Barbosa <debarbos@redhat.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] Documentation: real-time: Add kernel
 configuration guide
Message-ID: <20260305180741.7bd114f4@gandalf.local.home>
In-Reply-To: <20260305205023.361530-2-darwi@linutronix.de>
References: <20260305205023.361530-1-darwi@linutronix.de>
	<20260305205023.361530-2-darwi@linutronix.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: AEB9B20025
X-Stat-Signature: z5o75ma7sayq8tw47zzqrafys4qj81bi
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19NDJgygpWrsWb1PYpHdPezzEuUTIlJhLo=
X-HE-Tag: 1772752062-894614
X-HE-Meta: U2FsdGVkX1+Uo6DLkJ0nb4AD1Y4oP/on/GXFnfOUjOQOtkFncBjTuyK67cBAfYZWfCJhzekqUy3NiRNTK2GqIAnb16gmNeMTNP6GQkdBbqL/rHYcDJyTi77E69cnSGuqBaSfbF9bKzB6smxfi9S9iFUX3Ehz9TY5Tf7SRjNmmztpaZJJFh+16w1sh98PBazgOL5I7iGV2DoYWE86DMhpR+VZg4VkiUVAuni1kR1/3dVH7H7WjYKHbq1pxTggILuNDz2+mkjBii7WkXYP7nSZjB4op8gPkz5mu9K5vB39qlwUjaUt4qlexiIoAnMUB/uaRU2180aUuiipUhQaHZif+MHdhJmyS3AZSNTFgkawKa5nQyz7vTGMrNEeO/Xu6se4tGWzRDfNmHDOJp3AGGbQJve7eZD8zEh0yz/dsbtl2M0=

On Thu,  5 Mar 2026 21:50:12 +0100
"Ahmed S. Darwish" <darwi@linutronix.de> wrote:

> Add a configuration guide for real-time kernels.
> 
> List all Kconfig options that are recommended to be either enabled or
> disabled.  Explicitly add a table of contents at the top of the document,
> so that all the options can be seen in a glance.
> 
> Whenever appropriate, link to other kernel guides; e.g. cpuidle, cpufreq,
> power management, and no_hz.
> 
> Add a summary at the end of the document warning users that there is a no
> "one size fits all solution" for configuring a real-time system.
> 

Very nice document!

> Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
> ---
>  Documentation/core-api/real-time/index.rst    |   1 +
>  .../real-time/kernel-configuration.rst        | 297 ++++++++++++++++++
>  2 files changed, 298 insertions(+)
>  create mode 100644 Documentation/core-api/real-time/kernel-configuration.rst
> 

> +``CONFIG_EFI_DISABLE_RUNTIME``
> +------------------------------
> +
> +:Expectation: enabled
> +:Severity: *medium*
> +
> +EFI is the standard boot and firmware interface for multiple
> +architectures.  EFI runtime services provide callback functions to be
> +called from the kernel; e.g., as utilized by (``CONFIG_EFI_VARS*``) or
> +(``CONFIG_RTC_DRV_EFI``).  For the former, the kernel calls into EFI to
> +update the EFI variables.
> +
> +Calling into EFI means invoking firmware callbacks.  During such
> +invocations, the system might not be able to react to interrupts and will
> +thus not be able to perform a context switch.  This can cause significant
> +latency spikes for the real-time system.


> +
> +``CONFIG_PREEMPT_RT`` enables this option by default.  If this option is
> +disabled during the kernel build, pass the following boot parameter [1]_::
> +
> +  efi=noruntime

The above reads a bit funny. Maybe reword it to:

  ``CONFIG_PREEMPT_RT`` enables this option by default. If this option is
  manually disabled at build time, the following boot parameter [1]_ may
  be used to disable EFI runtime at boot up::

Or something like that.

> +
> +There is ongoing `development work`_ to allow EFI variables access for a
> +real-time Linux system.

  .. to allow access to EFI variables for a real-time Linux system

 ?

> +``CONFIG_TRACING`` (and tracing options)
> +----------------------------------------
> +
> +:Expectation: enabled
> +:Severity: *info*
> +
> +Shipping kernels with tracing support enabled (but not actively running)
> +is highly recommended.  This will allow the users to extract more
> +information if latency problems arise.
> +
> +.. caution::
> +
> +  Users should *not* make use of tracers or trace events during production
> +  real-time kernel operation as they can add considerable overhead and
> +  degrade the system's latency.

I wonder if a special note should be called out for:

  CONFIG_IRQSOFF_TRACER and CONFIG_PREEMPT_TRACER should be avoided as they
  do incur measurable overhead even when tracing is not currently active.

Maybe the above should be added in the "Problematic debug options"?


> +Kernel Debug Options
> +====================
> +
> +Most kernel debug options add runtime overhead that increases the
> +worst-case latency.
> +
> +.. caution::
> +
> +  During development and early testing, users are encouraged to run their
> +  real-time workloads and peripherals with lockdep and other kernel debug
> +  options enabled, for a considerable amount of time.  Such workloads
> +  might trigger kernel code paths that were not triggered during the
> +  internal Linux real-time kernel development, thus helping to uncover any
> +  real-time latency issues in the kernel.

Hmm, perhaps there should be some note that connects the use of "lockdep"
with CONFIG_PROVE_LOCKING below (as that is what enables lockdep). The last
sentence above makes it sound like lockdep can uncover latency issues, but
it will most likely cause latency issues. Perhaps a bit more explanation
should be used here.

> +
> +Problematic debug options
> +-------------------------
> +
> +``CONFIG_LOCKUP_DETECTOR``
> +^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Severity: *high*
> +
> +The lockup detector creates kernel timer callbacks that execute every few
> +seconds, in hard-IRQ context, even on real-time kernels.  These periodic
> +interrupts can cause latency spikes.
> +
> +Users should use hardware watchdogs instead, which will provide a similar
> +functionality without the software-induced latency.
> +
> +``CONFIG_PROVE_LOCKING``
> +^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Severity: *high*
> +
> +Proving the correctness of all kernel locking adds substantial overhead
> +and significantly increases worst-case latency.



> +Summary
> +=======
> +
> +There is no "one size fits all" solution for configuring a real-time Linux
> +system.  Beginning with the system real-time requirements, integrators
> +must consider the features and functions of the system's hardware, kernel,
> +and userspace.  All such components must be properly configured in order
> +to establish and constrain the system's maximum latency.
> +
> +With that in mind, any false real-time kernel configuration could cause a

  s/false/incorrect/ ?

> +new maximum latency that shows up at the wrong time and is catastrophic
> +for the real-time system's latency.
> +
> +References
> +==========
> +
> +.. [1] See :doc:`/admin-guide/kernel-parameters`
> +
> +.. _development work: https://lore.kernel.org/r/20260205115559.1625236-1-bigeasy@linutronix.de
> +
> +.. _Real-Time and Graphics\: A Contradiction?: https://web.archive.org/web/20221025085614/https://linutronix.de/PDF/Realtime_and_graphics-acontradiction2021.pdf

Nice job!

-- Steve

