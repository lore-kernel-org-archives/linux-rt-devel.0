Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656A7175A6B
	for <linux-rt-devel@lists.linux.dev>; Wed, 10 Jun 2026 06:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781071536; cv=none; b=VflI+9AAxL7b2lyifU+4tUn6UZmwtcaKg55dbYf3Qv77UGLeNfw1tOQsZFOI/y9tIOXoJ2Dd5K2AXgUmUADQ32EUtjCpsVrT3LZ9hg23uILXcpLK6g9T/qB7TmLUNbrObLqOtOYnf4U30CXUed70xFsyetX4iGa/x0J7CIuxfN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781071536; c=relaxed/simple;
	bh=y2wsVPelIEtMq3U3KX4WbY3IdmtftE3qpW7t6devt+s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NbWBgv4/6M7PHLy77ynfo3k0pe5BxyHAxNHvPnMhRfwfNrfO9az8oCF973zfzAyAVOjue163ILwI4rm/Mv7peLEk/GDtBlFjdKpvcUbzWv5aoNrXMofK7pgq7uEB+AzqytFXzqmyV0Iu3ZguJdY2CYPbsvVvVkU9ask+SJPKcrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpqNT5H0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpqNT5H0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291CC1F008A0
	for <linux-rt-devel@lists.linux.dev>; Wed, 10 Jun 2026 06:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781071535;
	bh=FTK5q5irjTJDtyh2inFzHi3DC2x4G3YrOl+FUqbTtH8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=fpqNT5H03zbQNgcEVq8Rf7kstpehLDgDtoQJMjmCbSdBf00/H1epyiItcyJpXohlQ
	 Lx6AFszxQRQaQ/UVRHWpVyM3stQhrHWcYVEOOOYSjGozSjhMxhCBbeSGRNEVgxUKlH
	 zGIFBMlgmQFaKFgwDmZxqjtl/Wz36hbwdLFEK0mFu+LWQubJIqWNgrlP4YQxmUVx2Z
	 USuXQMM5zXrbjNAZAQ9l/7AVWWjR1WEpn4vBBqsiipqWP49mhnjvp9PZrfRX8cGsqI
	 Kb0VbC97YQP2q/tuI2iQcszTRFbbYeeSrhNQ0pZCZ789R0zXHe76yCrGQCqRB8oyqJ
	 Ak0vWUhyTAdhQ==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-687ed9aabb3so12478945a12.1
        for <linux-rt-devel@lists.linux.dev>; Tue, 09 Jun 2026 23:05:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9NycSUYTXEHnBkrmF3rechhOpNyVCXICA9QUtesMWAuzHnIkXCZgvyODUPzmWBF5f62fjdKYwsiAM+VxEf4Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YzmFDxEWCgUTes1HMq1wAnIAGGVsWqJ9zUnOg0RXdfWYgLeeCTl
	9cDRu03vNh7rRbpLDibDTKS/on+N90j8R6CZLkjvADgCTtjBji1JAIg5mImf3jniOXNwPPbgCb5
	w225i2jatskgJEgLuN6SHEPnP4kjnjNA=
X-Received: by 2002:a05:6402:518c:b0:68c:627d:fc2b with SMTP id
 4fb4d7f45d1cf-68fa5039e51mr10638713a12.16.1781071533743; Tue, 09 Jun 2026
 23:05:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260608093729.12111-1-jelonek.jonas@gmail.com>
In-Reply-To: <20260608093729.12111-1-jelonek.jonas@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 10 Jun 2026 14:05:56 +0800
X-Gmail-Original-Message-ID: <CAAhV-H7vJ5YniUD8HhFWBbypNyWTo73M_vzw=Y-MZtR-b_RNfw@mail.gmail.com>
X-Gm-Features: AVVi8CeBRd2PLLuFTXLO59EuacgjVdNmuBqSnRmL8jqW-pPNGJNNz_1TkdYV9Ms
Message-ID: <CAAhV-H7vJ5YniUD8HhFWBbypNyWTo73M_vzw=Y-MZtR-b_RNfw@mail.gmail.com>
Subject: Re: [PATCH v2] MIPS: smp: report dying CPU to RCU in stop_this_cpu()
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jonas,

On Mon, Jun 8, 2026 at 5:37=E2=80=AFPM Jonas Jelonek <jelonek.jonas@gmail.c=
om> wrote:
>
> smp_send_stop() parks all secondary CPUs in stop_this_cpu(). The function
> marks the CPU offline for the scheduler via set_cpu_online(false) but
> never informs RCU, so RCU keeps expecting a quiescent state from CPUs
> that are now spinning forever with interrupts disabled.
>
> As long as nothing waits for an RCU grace period after smp_send_stop()
> this is harmless, which is why it went unnoticed. Since commit
> 91840be8f710 ("irq_work: Fix use-after-free in irq_work_single() on PREEM=
PT_RT")
> however, irq_work_sync() calls synchronize_rcu() on architectures without
> an irq_work self-IPI, i.e. where arch_irq_work_has_interrupt() returns
> false. That is the asm-generic default used by MIPS. Any irq_work_sync()
> issued in the reboot/shutdown path after smp_send_stop() then blocks on
> a grace period that can never complete, hanging the reboot:
>
>   WARNING: CPU: 0 PID: 15 at kernel/irq_work.c:144 irq_work_queue_on
>   ...
>   rcu: INFO: rcu_sched detected stalls on CPUs/tasks:
>   rcu: Offline CPU 1 blocking current GP.
>   rcu: Offline CPU 2 blocking current GP.
>   rcu: Offline CPU 3 blocking current GP.
In theory LoongArch has the same problem, but I cannot reproduce,
should I enable PREEMPT_RT? Or there are some special configurations?

Huacai

>
> This issue was noticed on several Realtek MIPS switch SoCs (MIPS
> interAptiv) and came up during kernel bump downstream in OpenWrt from
> 6.18.33 to 6.18.34, after the backport of the patch to the 6.18 stable
> branch. The patch also has been backported all the way back to 6.1.
>
> Call rcutree_report_cpu_dead() once interrupts are disabled, mirroring th=
e
> generic CPU-hotplug offline path, so RCU stops waiting on the parked CPUs
> and grace periods can still complete. MIPS shuts down all CPUs here
> without going through the CPU-hotplug mechanism, so this report is not
> otherwise issued. Reporting a dying CPU to RCU outside the regular hotplu=
g
> offline path is not unprecedented: arm64 does the same in cpu_die_early()=
.
> There it is an exception for a CPU that was coming online and is aborting
> bringup, rather than the default shutdown action as on MIPS.
>
> Fixes: 91840be8f710 ("irq_work: Fix use-after-free in irq_work_single() o=
n PREEMPT_RT")
> CC: stable@vger.kernel.org
> Signed-off-by: Jonas Jelonek <jelonek.jonas@gmail.com>
>
> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
> index 4868e79f3b30..0f28b4a62e72 100644
> --- a/arch/mips/kernel/smp.c
> +++ b/arch/mips/kernel/smp.c
> @@ -20,6 +20,7 @@
>  #include <linux/sched/mm.h>
>  #include <linux/cpumask.h>
>  #include <linux/cpu.h>
> +#include <linux/rcupdate.h>
>  #include <linux/err.h>
>  #include <linux/ftrace.h>
>  #include <linux/irqdomain.h>
> @@ -422,6 +423,7 @@ static void stop_this_cpu(void *dummy)
>         set_cpu_online(smp_processor_id(), false);
>         calculate_cpu_foreign_map();
>         local_irq_disable();
> +       rcutree_report_cpu_dead();
>         while (1);
>  }
>
> --
> 2.51.0
>
>
