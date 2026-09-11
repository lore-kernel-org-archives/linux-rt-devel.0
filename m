Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF2D35F8C5;
	Fri, 11 Sep 2026 14:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789138557; cv=none; b=P4chl81f9MpuKN2a86wpt8rugUlkL0DRDCKsKc7g1w4fdflz8bWptpH9wcljSZL/RxhGV7Dz2FgdAcvmpS/LSOGpCbtQbhd/fJimHBhogtIs+YBDp85QQ1obUZRq02SmZ/8Gexp2x1SZptKVbZv6oEV7MW5R2jrkAoz2QNp+j8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789138557; c=relaxed/simple;
	bh=KjCMr93PTFov7gyqhGK83knHGp41cZ419o05C6nHwc0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ebc9BV2mspZh2WrB8w8lB0YG3qVsxPqjGA+JVG9ozyJDOXijIy6FoGUvYPaZv/rp7u1s8Kj6BEKxI9kd9zfsd3BB54uOaTteiQgUnPiQBtvDEJrK+sZIO70eoS9suQYo0LFbFrkhrNzVX3lnj+mbrZgW14XykF27FtESpxxQVG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aTsL7gTR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aTsL7gTR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE8C1F000FF;
	Fri, 11 Sep 2026 14:55:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789138555;
	bh=qkZ4IyVvStUJzakzj5R5H25jdgCJRE7/sNTSWMjUtDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=aTsL7gTRbqvy4z1G6/QhBAykaUiCrVMtt/L1GVMu+hamQ0tU+drIL6P+fULAaFqGZ
	 OZ8UCqdoQ4zpT9FLN3jXiB8ulNwtHuKvo+YwL67kWwJWTDcEXEdue8pNth+TtwHar3
	 3ktykKEXFu5m8Jh0xfn8038AwHyMd79sEY7Lz/HSOPivaY2lCDfhPw/W76PVznLewW
	 pPKN5EHYs0wWZ6JSVdVbRHwtHzxb3CKtAVx1eARyyJodseDoc09/NSNOcIfCZFFYm3
	 8+munRNtbW+AnrW989kPJxKHQTpRzZCp6jFfvc9PVj4PdJyHFz9wY0K9gzJDge1Ik6
	 cHnIz4+gDzHaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] irq_work: Flush lazy work CPU down on PREEMPT_RT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sebastian Andrzej Siewior" <bigeasy@linutronix.de>
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
In-Reply-To: <20260911143815.997254-3-bigeasy@linutronix.de>
References: <20260911143815.997254-1-bigeasy@linutronix.de>
 <20260911143815.997254-3-bigeasy@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 14:55:55 +0000
Message-Id: <20260911145555.8BE8C1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Executing a dying CPU's lazy irq_work callbacks on the control CPU=
 violates `this_cpu_*()` assumptions, leading to memory leaks and state cor=
ruption.
- [High] Use-after-free of `irq_work` structure due to missing `rcu_read_lo=
ck()` in `irq_work_run_cpu()`.
--

commit c2c4af12bef2f74291db156f37cadb81d93b8598
Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

irq_work: Flush lazy work CPU down on PREEMPT_RT

This commit adds support for flushing lazy IRQ work for a dead CPU when
PREEMPT_RT is enabled. It introduces irq_work_run_cpu() to process the
dying CPU's lazy list from the control CPU during smpcfd_dead_cpu().

> While looking through the users of irq_work, it does not matter if the
> callback is enqueued on another CPU. This makes it possible to invoke
> the callbacks from a remote CPU by smpcfd_dead_cpu().

[Severity: High]
Is this statement accurate?

Several lazy irq_work callbacks (e.g., cgrp_dead_tasks_iwork_fn in
kernel/cgroup/cgroup.c) rely on this_cpu_*() accessors to process local que=
ues:

kernel/cgroup/cgroup.c:cgrp_dead_tasks_iwork_fn() {
    ...
    lnode =3D llist_del_all(this_cpu_ptr(&cgrp_dead_tasks));
    ...
}

Executing them remotely on the control CPU causes them to access and drain =
the
control CPU's per-CPU lists instead of the dying CPU's. Could this permanen=
tly
leak task structs and pin cgroups on the dead CPU indefinitely, while
incorrectly altering the state of the control CPU?

> diff --git a/kernel/irq_work.c b/kernel/irq_work.c
> index 9f19c05c9962c..73eabcbdcd50c 100644
> --- a/kernel/irq_work.c
> +++ b/kernel/irq_work.c
[ ... ]
> @@ -263,6 +263,17 @@ void irq_work_run(void)
>  }
>  EXPORT_SYMBOL_GPL(irq_work_run);
> =20
> +void irq_work_run_cpu(unsigned int cpu)
> +{
> +	if (WARN_ON_ONCE(!cpumask_test_cpu(cpu, cpu_dying_mask)))
> +		return;
> +
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
> +		return;
> +
> +	irq_work_run_list(per_cpu_ptr(&lazy_list, cpu));
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Could this result in a use-after-free of the irq_work structure?

irq_work_sync() protects against concurrent execution by waiting for
IRQ_WORK_BUSY to clear and then calling synchronize_rcu(). This assumes the=
 work
callback executes inside an RCU read-side critical section.

However, irq_work_run_cpu() runs from preemptible thread context in
smpcfd_dead_cpu() without holding the RCU read lock. irq_work_single() can =
be
preempted after clearing IRQ_WORK_BUSY but before calling rcuwait_wake_up().

If irq_work_sync() on another CPU sees the BUSY bit clear, it will call
synchronize_rcu() which returns immediately, and the caller may then free t=
he
irq_work structure. When the preempted work function resumes, could it acce=
ss
freed memory in rcuwait_wake_up()?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911143815.9972=
54-1-bigeasy@linutronix.de?part=3D2
