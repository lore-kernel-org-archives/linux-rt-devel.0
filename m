Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5A3C3DFC96
	for <linux-rt-devel@lists.linux.dev>; Wed, 11 Mar 2026 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773243313; cv=none; b=r1Twyb4VxHmZHhnbvJa+v8QEJ3iUEZqsnWRgDrKHNqsVQ6+2qfn7PK2SJSN0oZrtKW762h1gAHlpjpSzcU5akUWTqXYRLIbDyLnYth1kvWqm0m/IcBOmsB0nLm3nmtOTOTl5Y2JhI0+ZJfk/9ylkU+RjBtyh42UkUxQgi/AFBqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773243313; c=relaxed/simple;
	bh=lOK3/fQqyV60rKy+T5BaO1VIfp0//9bYfNpjSEe6siQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lUceph3CiP3wjlGphPmOwoA+VAcN5/AOzw4yaEApYxKHRD7HzkXa6LX0QG144o2y+wYwXcBM2wQ+XD6y5wBMCpDdlswBRxIKYN+h/2hjpzgVKCthtli0MtY1WYp4QIEWisncI1E/n8kDqAJz5us28GjwQ2jkUeacKUy3WbA+/5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cWOBmqej; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cWOBmqej"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ZY
	hmZygM/34eHupicECYnnXenpR9YprANUR8zIBylNo=; b=cWOBmqej3e1q1qUHgY
	jGlqZHrP+h7TFZJTiGKZbI2uZ7+t4gE30tciW2jqNsloXnc4IkcOcWekB6bIsmcj
	oF3sSLJJUKQjdOIUuWTvYGK2cCOfvduXT4FbdIR9vIys48/50nma1FSvEoHKlH18
	fGI6vgdvc4U3ONAYlR7Qt1+u0=
Received: from zhaoxin-MS-7E12.. (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgA3K81qi7Fp5TJ9RA--.9775S2;
	Wed, 11 Mar 2026 23:34:04 +0800 (CST)
From: Xin Zhao <jackzxcui1989@163.com>
To: bigeasy@linutronix.de
Cc: boqun@kernel.org,
	clrkwllms@kernel.org,
	jackzxcui1989@163.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	longman@redhat.com,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	will@kernel.org
Subject: Re: [PATCH] softirq: WARN_ON !preemptible() not check softirq cnt in bh disable on RT
Date: Wed, 11 Mar 2026 23:34:02 +0800
Message-Id: <20260311153402.230138-1-jackzxcui1989@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260311145149.dU2xpGoO@linutronix.de>
References: <20260311145149.dU2xpGoO@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgA3K81qi7Fp5TJ9RA--.9775S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF1UKry3Kr4rZrW3ur1xXwb_yoW8Kr4Upa
	n2gw48Kr4DXFyIvwsrAwn2gF1j93y8Jayjkw1Fk3y2y39xtr1kXrn7KF1UZa9F9rWFqw10
	vry29FW3ua4UZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUnzV8UUUUU=
X-CM-SenderInfo: pmdfy650fxxiqzyzqiywtou0bp/xtbCwAzEzmmxi2z2YQAA3u

hi, Sebastian

On 2026-03-11 14:51 UTC, Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:

> > I just think that using (system_state != SYSTEM_BOOTING) for conditional checks
> > is more reasonable than using (softirq_ctrl.cnt).
> 
> We had users which which did
> 	local_irq_disable();
> 	local_bh_disable();
> 
> and we decided not to bother if there is no reason to.

If there are users have such usage, it will probabilistically hit the print statement
for DEBUG_LOCKS_WARN_ON(softirq_ctrl.cnt). This is because the task running this code
may preempt a task that has already entered the local_bh_disable critical section.
Isn't that right?

> > I should use the situation where CONFIG_PREEMPT_RT_NEEDS_BH_LOCK is enabled to
> > illustrate the example above. People would expect that soft interrupts on this
> > CPU would not execute after calling local_bh_disable(), but as shown in the
> > example, this cannot actually be guaranteed.
> 
> If CONFIG_PREEMPT_RT_NEEDS_BH_LOCK is enabled then the scenario is
> possible but the DEBUG_LOCKS_WARN_ON will trigger a warning.

Indeed, it will trigger this warning; it just reduces the probability of it being
reported.

> Hmm. Is there actually anything wrong in tree?
> Longterm I would intend to make !CONFIG_PREEMPT_RT_NEEDS_BH_LOCK
> default.

I am tracing the soft interrupt code interface and found a _local_bh_enable interface
that only exists in non-RT Linux. This _local_bh_enable is used in sclp.c as follows:

    local_irq_disable();
    local_ctl_load(0, &cr0);
    if (!irq_context)
        _local_bh_enable();
    local_tick_enable(old_tick);
    local_irq_restore(flags);

I did not further investigate why the above code in sclp.c is not used in RT-Linux. As
for why _local_bh_enable does not exist in RT-Linux, it may be due to the consideration
that local_bh_disable is "ineffective" in the !preemptible() state in RT-Linux, but I'm
not sure if my understanding is correct.

Since you also mentioned that later CONFIG_PREEMPT_RT_NEEDS_BH_LOCK will no longer be
enabled, at that point, local_bh_disable almost loses its significance. I think it
should either be removed or implemented as a no-op, as it no longer achieves our
expected effect, and it would be better to save some instruction execution time.

Xin Zhao

