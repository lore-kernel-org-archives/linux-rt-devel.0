Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC2428D8E2
	for <linux-rt-devel@lists.linux.dev>; Tue, 10 Jun 2025 11:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749553330; cv=none; b=KSYpHfIJ5Jb5fzupSX0YAL2KddtaiUPc97rzyvXX6hkHR0xk08DjlrYYvHE2N9q1wcX2B6DfEQaNhjpbMR6Mi7AacwFimDBSoVEAj8E1VTvNzBOv/cDVyqdNNNzxIuyCj4U/k2MeubJcigHG6Jc+C+/wmMtYk8fBE1G1gwTQzNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749553330; c=relaxed/simple;
	bh=vWv+8nKiKM5W+qeTFCBUN2zIm0sGjmIsW/nu1TSvwh0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=huvB/rJyDoO1WAAJBErd2H8iBJj4Gl7rspZs4LUSbvF7lJDaD7/Uyk5bndeRFPkeZR/AiX93WVoA9MpvaBIU1vhUXEPNMaEmtLXweGsLJr09cEMdzg08WxRCd+8AdWIiH3ZO6KFYgIR7lQXWo7i5HOv5hTu3S//WdOVw5UOMb1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G+NuyHID; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9wGCEaMS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G+NuyHID";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9wGCEaMS"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749553327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g1cFxmbL7LoHrRwLUt7qm2d763Ed3orp58GiqXGJoPU=;
	b=G+NuyHIDaCRfqyCzSxN/ef2w/WGW440Gb2fWewQ0eCwBPJhP3a8Hwjwevcy47h3CUzyOtx
	xgBBpg0yLUCziVteL5IJJfPitJ7Raw5y/s1VlQQ1R7Fn5MGfcqsEQ+AxWqtqwgcEFC2tq7
	uDooH/P7Mew4ym/2SXurOOytpDtl6xI1YxTe0pnxrpVndAOuQ1WZTLYK+I0G/dU16P2Wgc
	EA7YaPl+aUxQwg5YU69IGr5DpF11ISu/LfU4W/G9vDBKpVxQgKTrxTUP13g2Rybni/1ZVb
	OsGCidAovIJ60JGTomGmkK7ekfYd9vyOhoXOC3jFNuOVciERlqeSwzMsE6pHbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749553327;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g1cFxmbL7LoHrRwLUt7qm2d763Ed3orp58GiqXGJoPU=;
	b=9wGCEaMSZMxz8VBaOsbtXwofJlWJBvOaUUcHcdZu2jbcVJ5qA8PZU4AjdUaaupxCGIDkgS
	UZhF1QufS2Ob0aDw==
To: linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Cc: tglx@linutronix.de,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 0/1] local_lock: Move this_cpu_ptr() notation from internal to main header
Date: Tue, 10 Jun 2025 13:02:03 +0200
Message-ID: <20250610110205.1111719-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

While looking at what needs extra locks for PREEMPT_RT in order to rid
of the lock in local_bh_disable() I stumbled uppon two users which need
to lock the structure but the pointer is no longer per_cpu.

The moves this_cpu_ptr() from the internal header to the main one in order =
to
free the name space and have the __ prefix function to do the same but with=
out
the this_cpu_ptr(). This gives us
    local_lock_nested_bh() -> on per-CPU memory
  __local_lock_nested_bh() -> on local memory.

This change has been made to all local_lock*() functions.

I made an example for the crypto user
	https://lore.kernel.org/all/20250514110750.852919-3-bigeasy@linutronix.de/

and would route if via crypto once this is accepted.

v1=E2=80=A6v2: https://lore.kernel.org/all/20250514110750.852919-1-bigeasy@=
linutronix.de/
   - Repost without the crypto user.

Sebastian Andrzej Siewior (1):
  local_lock: Move this_cpu_ptr() notation from internal to main header.

 include/linux/local_lock.h          | 20 +++++++++----------
 include/linux/local_lock_internal.h | 30 ++++++++++++++---------------
 2 files changed, 25 insertions(+), 25 deletions(-)

--=20
2.49.0

