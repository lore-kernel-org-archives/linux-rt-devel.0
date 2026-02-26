Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623DE42885A
	for <linux-rt-devel@lists.linux.dev>; Thu, 26 Feb 2026 16:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772123861; cv=none; b=pgikEfSSTRxJ72pRvOfof+w7fv70/Ys/N/5Pk4dQuoTu5wRJ3+68HghBErF5d2mAmLQAYKa7L39Nz0xuUMGfesA4M+1P1r15yGVRy95TPe4ZUVDhVVtPAIVDAJWCdowNoXob2aKNYy6u05ian7XI5WpSvU4BTO/EHDnlM6uuSvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772123861; c=relaxed/simple;
	bh=XpBSmgpMsaMoutF/YCCxrxztWj7XXQ0lgLi9u3Jwd7E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ePrc7N1tF2H0Uq07MtmTJ+p4X0xqJ1/ZCGsu6yUDLVL/jHB7m2+VM9eWovRvcFAlvEL0yby7tz22GnkvP5lYjb7cYmwtIvf4iGrM+cZzNBjMSClb4w8+o1fzDac4ZzQF6ofCtGFTcpN/0ZRvmwI5BDgMZTzOZr/hiACsw3qf/EQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id BC5A9534EC;
	Thu, 26 Feb 2026 16:37:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 8394880012;
	Thu, 26 Feb 2026 16:37:36 +0000 (UTC)
Date: Thu, 26 Feb 2026 11:37:58 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tejun Heo
 <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, calvin@wbinvd.org,
 dschatzberg@meta.com, peterz@infradead.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: ~90s reboot delay with v6.19 and PREEMPT_RT
Message-ID: <20260226113758.6ff33946@gandalf.local.home>
In-Reply-To: <b5a3f7a9e83e19209b1bd054e8bd8dfff0d22317.camel@web.de>
References: <aQufmyZ7X7NdfiCL@slm.duckdns.org>
	<20260219164648.3014-1-spasswolf@web.de>
	<20260225154341.32AjXoVi@linutronix.de>
	<6abee0b4bca811680a7f7fb6ab70bf27c6805cf5.camel@web.de>
	<20260225165954.180aRkaV@linutronix.de>
	<20260225223135.vjfaFo0c@linutronix.de>
	<b5a3f7a9e83e19209b1bd054e8bd8dfff0d22317.camel@web.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 8394880012
X-Stat-Signature: d45o7qyzcnx6hq575jujp9oi6mjt3yf9
X-Rspamd-Server: rspamout08
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+vuCumGQGyTlK/Iq8XbFJTgTB97ZA30LQ=
X-HE-Tag: 1772123856-826326
X-HE-Meta: U2FsdGVkX18vnu2wI3HCpGkpE5xdG+3XWJ6wGKVyOc2XF+WhboEBsJVyM30Y3S/xv8TJ8bXs8G9bVhnR/9P3zUkNzy8n42MHQfVrQvk2TcoLduTS3btzUfzwZ57pyfQExTN/neuE1k14ymlYlDdyKb3AZsSoELRxE+6rl9u09dQfxpT8K/24j4RrfFu5CqpeBSDLjPlrl3t1agLqm0ZINrEV4QeRl9sjh+GMGGdVlXxbZzh5EKgqCv3WVPKHJLPsP6Jmd49HpZ8ssuDZcxKhTXUqo7kdV5wev6XplLvvyHf2gAOBOdQ8uuwQ1e4afLQW

On Thu, 26 Feb 2026 14:24:34 +0100
Bert Karwatzki <spasswolf@web.de> wrote:

> I think I've found the reason for the stall. I was looking at commit 9311e6c29b34
> ("cgroup: Fix sleeping from invalid context warning on PREEMPT_RT"),
> and noticed this:
> 
> +static void __init cgroup_rt_init(void)
> +{
> +       int cpu;
> +
> +       for_each_possible_cpu(cpu) {
> +               init_llist_head(per_cpu_ptr(&cgrp_dead_tasks, cpu));
> +               per_cpu(cgrp_dead_tasks_iwork, cpu) =
> +                       IRQ_WORK_INIT_LAZY(cgrp_dead_tasks_iwork_fn);
> +       }
> 
> IRQ_WORK_INIT_LAZY() expands to __IRQ_WORK_INIT(_func, IRQ_WORK_LAZY):
> (in include/linux/irq_work.h)
> IRQ_WORK_LAZY is declare in include/linux/smp-types.h:
> 	IRQ_WORK_LAZY		= 0x04, /* No IPI, wait for tick */
> 
> The "wait for tick" gave me an idea as I'm also using
> CONFIG_NO_HZ_FULL=y

If you disable NO_HZ_FULL, does the problem also go away?

I wonder if you add irq events and trace a good and bad boot to see if it
definitely shows the delayed tick being an issue.

  echo 1 > /sys/kernel/tracing/instances/boot_map/events/irq/enable

-- Steve
