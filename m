Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 996993D6674
	for <linux-rt-devel@lists.linux.dev>; Fri,  5 Jun 2026 03:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780628498; cv=none; b=PkVBVnylIgtD7QsaLUhKkbRcY66WVwEaewbh5cwqKEmx5u3I1fdVfBzfLFXg0dSu+bDWjH8ZnHXLyh9PL2TYqW31JxIDK37O+AISVs9ZJGppjU9an8q3x9XVwJuFBCuJdy3Ey23QaCW5hrUtSq11t/Dr+xqvbAKyyhxqufhsDso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780628498; c=relaxed/simple;
	bh=8oFkNBae0WeW+XySIH1TOUSpYWfTkzh/iTHSAUFFS/E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ERj7jnn1LJ5dmJermgsO9pKi9ru8KQx+MbSSm2vSHevROFhqotDfcwVTsZ6/27eZnGEEx+U865L0OFQgMQn1gBzNL4lbpYdIpaE0zFGCLZfMaz5CiKPV7BucRzgcEn00EX0zk5rG1zaRQckI6xduVHucXGZoxJEmwotryaI5MqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cqNVU2vx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cqNVU2vx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D6961F00899
	for <linux-rt-devel@lists.linux.dev>; Fri,  5 Jun 2026 03:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780628492;
	bh=Qot5MKbUL/+0V3hX55HDcvFA3oU5tA4W2gsnoTLBjzk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cqNVU2vxL4eaEV0/nqpzC3gpvg19r6Jy7XmFvYTbMBAIAp+DWAy9pbrPZKQe6xWzk
	 GL+THwP9U4h3glbl63IUpsWpmbf7A0gJfoEyQxLz+tBmKA0cg5UU+1CztDt53mki2G
	 K2HYiFUqWLXc9lY61zyL8uP/acdiLIzkFclr5KV3AWRrKLBwmbAQC15/W5pt/fqyKK
	 v3kn4sKeZjfytGHvoPyKVhuq2WTJqpIMaThWGetRGalo6ksCqg4DwuyfpX0ZC2zJ0P
	 pyp0Q3dxb+oXVN+vWITrlVLWNHJc2zPyTPyLTTNpO0quE5X/vPXHg7iNzcdzqqK2k7
	 /IcyM9QwcxhbQ==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-bec449d0af2so165591166b.2
        for <linux-rt-devel@lists.linux.dev>; Thu, 04 Jun 2026 20:01:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9Ol22XM4zxQHMslrbxO3w+qAY3zuRlHQAFi+Nm1eZC5Ti0XOFpTMS8TQ1f6/+odMyFuC5LYiuR9h7OJ3wSvw==@lists.linux.dev
X-Gm-Message-State: AOJu0YzpRVCcusvBYzdxkRpVDr4EkRr+hoLuFi0hYPHdQ4kiOrD5cC2F
	4HOlRy1NFBBqq7iqCnX+9TptKmZmp56FjNuEl8rmJgzaS7EytopieK+nggTUUkbDa9x3RBJGDdR
	8zJMJmbXprUxQq037S24cjU5hg9ryM8s=
X-Received: by 2002:a17:907:9486:b0:bd4:7bed:512a with SMTP id
 a640c23a62f3a-bf372159fecmr59795766b.30.1780628490779; Thu, 04 Jun 2026
 20:01:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260604182407.3109536-1-jelonek.jonas@gmail.com>
In-Reply-To: <20260604182407.3109536-1-jelonek.jonas@gmail.com>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Fri, 5 Jun 2026 11:01:51 +0800
X-Gmail-Original-Message-ID: <CAAhV-H6khmNSNLOpVzV2B9qmRVAZkY6w8nYVrJC6QBP5CrFd3w@mail.gmail.com>
X-Gm-Features: AVVi8Cff9VD9kkc76jgjyhmWfyiyAtuxoVRhN2LR48HGLll75a6yTaczl2ar0aU
Message-ID: <CAAhV-H6khmNSNLOpVzV2B9qmRVAZkY6w8nYVrJC6QBP5CrFd3w@mail.gmail.com>
Subject: Re: [PATCH] MIPS: smp: report dying CPU to RCU in stop_this_cpu()
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@kernel.org>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, linux-rt-devel@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Jonas,

On Fri, Jun 5, 2026 at 2:25=E2=80=AFAM Jonas Jelonek <jelonek.jonas@gmail.c=
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
>
> This issue popped up during kernel bump downstream in OpenWrt from
> 6.18.33 to 6.18.34, since the suspected change has been backported to
> 6.18 stable branch [1].
Now 91840be8f710 ("irq_work: Fix use-after-free in irq_work_single()
on PREEMPT_RT") has been backported to as early as 6.1 LTS.

>
> Call rcutree_report_cpu_dead() once interrupts are disabled, mirroring th=
e
> generic CPU-hotplug offline path (and arm64's stop handling), so RCU stop=
s
> waiting on the parked CPUs and grace periods can still complete.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/comm=
it/?h=3Dlinux-6.18.y&id=3D18c0456ea2615b1a743a6db739c74411c3b42bc6
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
I'm not sure but maybe it is better to before local_irq_disable()?

Huacai
>         while (1);
>  }
>
> --
> 2.51.0
>
>
