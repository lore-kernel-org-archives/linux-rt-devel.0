Received: from r3-25.sinamail.sina.com.cn (r3-25.sinamail.sina.com.cn [202.108.3.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AF12D7DFE
	for <linux-rt-devel@lists.linux.dev>; Mon, 21 Sep 2026 01:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.108.3.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789955008; cv=none; b=VOqqDAQJGAu5ITdETkAueMaktkuiLX6NpiMUkW54PrJTy4ToSqZiBvfeR/PM/2NACQ1gSXwhzozkXwbJS5rfVnS4jaT0elhSrTSznhzx15HEswlrUhbXouzOQrnbK3kBPI1yiTvgw6DOx9jli1YzYHRMxTXILHq/BsILtp5uP4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789955008; c=relaxed/simple;
	bh=qhiIOzYtmp0hEvN8BoHvxGac4o9/FV+baZpvWJ/G2mM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NRRpp9JYsRs9Yv7r2VopaGU39jicSXa3mmBv0SfYtGBPNsAmUyNNkVZiAGeOtuT/TQ53k47Hbr1ae8IRgNuAY1gY6wDKX8TJDaH07drmjToljEMM2ZqPWRXYQWu8iM05roNjiB7y0l7O1pZfJKpZXYMdLyGjit5jZzBtAUX+i/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b=g9ulZSQJ; arc=none smtp.client-ip=202.108.3.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=sina.com header.i=@sina.com header.b="g9ulZSQJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208; t=1789955003;
	bh=rU8vDUUQ7doPy3YsLbyw7gkk+iHfUwEdGMQu7Mfk3k4=;
	h=From:Subject:Date:Message-ID;
	b=g9ulZSQJqh5H7Hc0ax4KyQs2z/ursFhh6da+n36MBe90CYzEgQ/XwnDZy0z7P14qL
	 jshtiwfEPWAZhsat8DqnzlsHOYwVEV/WuFgTUpcjX9WMKppw4l5OneMFFvVK51+a1U
	 QX9+8QK2FlmYUzA2WYchbygA4set6wZUAq7zLWhM=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([114.249.62.194])
	by sina.com (10.54.253.31) with ESMTP
	id 6AB08BAE00006CA8; Mon, 21 Sep 2026 09:43:13 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 334586815960
X-SMAIL-UIID: D2FB78204DD5429D972AB8B184240CDA-20260921-094313-1
From: Hillf Danton <hdanton@sina.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: linux-kernel@vger.kernel.org,
	rcu@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-rt-devel@lists.linux.dev,
	linux-kselftest@vger.kernel.org,
	Paolo Bonzini <pbonzini@redhat.com>,
	Sean Christopherson <seanjc@google.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 01/17] KVM: pfncache: Use atomic SRCU for readers instead of a rwlock
Date: Mon, 21 Sep 2026 09:42:56 +0800
Message-ID: <20260921014301.248-1-hdanton@sina.com>
In-Reply-To: <20260920211920.928306-2-dwmw2@infradead.org>
References: 
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Sun, 20 Sep 2026 21:49:29 +0100 David Woodhouse wrote:
> 
> Replace the per-cache rwlock with a dedicated per-VM atomic SRCU
> domain (kvm->gpc_srcu) for the read side. Readers now run under
> srcu_read_lock_atomic() alone — preemption disabled and non-blocking
> enforced, which every GPC read-side section already satisfied as a
> former rwlock critical section. It works in any context
> (including hardirq and sched-out paths) and never fails or spins,
> eliminating the
> read_trylock() contortions in the atomic paths, the double-lock dance
> with the lockdep subclass hack in the runstate update, and the
> PREEMPT_RT problems inherent to taking an rwlock in those contexts.
> In particular, kvm_xen_set_evtchn_fast() is called from hardirq
> context (timer callback, kvm_arch_set_irq_inatomic()), where taking
> gpc->lock is a sleeping-lock-in-atomic-context bug on PREEMPT_RT.
> 
Given the preempt_disable() in srcu_read_lock_atomic(), as PREEMPT_RT
has no way of handling preempt_disable(), you need to add another
version of srcu_read_lock_atomic() with preempt_disable() replaced with
something like rcu_read_lock().
