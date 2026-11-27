Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787334;
	b=c6Ki4hVnIpO/AT4bDJ1co2Z3ewOrIykFirf+2W7i7oXkW9SWpgknjUt+53l4W0J+LLx3
	 pIGn1OBT8pWHX+uSastiPLcvOM4FrIe64wY6QWccAYi2w/xIN2WfewRSd4Kj9MB3HQVwr
	 bKQDsvO1rVS5C386cEkMCq8Gh42vNZo6C10VRjcBhqJXKQvTTNEChRwAljjuSvQHkEXh5
	 5Ka2Pgp6Dh7K2J/Y7jW5SUwx7IGF15sTYbkdEygK749fbDtaDrsBB5qAM7xfB7q+a9kB+
	 B0q1nRk1h7JCTLEXP7ol6EDgHqld7WBV5mlPR0mlPNiRNbgNKmwh6ELGenFXSF+SE4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787334;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MSYIcziIwRSDABafMhYd5nZ/EY2BY2PcFurnMAD085U=;
	b=wz6PowrTN+MhpLUYdPIZmkGwc3yrWfYL2qPcnRjdjcinM612eq9RwqeT2+rzpbFtYl8q
	 G4X1XV7V773rqcqhtDDdPPW+GDvAZvA+VGn6pty0uRJ1mHpd7sSCRUhpM1VdbZQWzPICY
	 eGtl9hh/xao92/Xn/EYWRjWKG7izIyCMEGh0QeX6BelMg6xNQQFvY+ht7Vst5SHjKlMuH
	 8lPRjAW5EydzY/F1XB0tJruYGn3EdWwgUwjm/WDtINcsDXaxW8LsPn5ouZ6kI0RPvJ3ut
	 fCZRcEqZb66yQnv5MFcitH/kej9AHsDiGHFOYOdM3G673gxc99s4SuIUpsh7DVfJ3+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=t+CV2BuU;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D056606A685;
	Fri, 27 Nov 2026 13:48:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D056606A685
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=t+CV2BuU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795787327;
	bh=MSYIcziIwRSDABafMhYd5nZ/EY2BY2PcFurnMAD085U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t+CV2BuUj2dixflQSNZ6qtqVuhdG0Fj9rrnqKGDhN/LKqo8r/sZM6KVFVwyMLBTTF
	 xLmixUb7bDFA5vVQQt7NVMwDpCgd+l54E5xHSp6ybMHodNfAPLPR80A07qt9vMmVZ3
	 pTpRUAa3HL2ctsOLf/1aHcRKHp9UQLwmfFcKemOF4nnfhzJOZ5gIaiZqDS6ix4AfXM
	 hgg1jx7F42Or8gIMhv37jOvb6RleSsXzJaPevKbNBIEoIwTiKAyXGOMdpEIcrbKL+6
	 wXsfoDp5mJnn9NFsW970KnG8G4D/oA+wDMWE6KOkmJvR1Owm1E/jk/WpBxXMUJ0h52
	 OrKVKkMMfdSOA==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jbZWf72nhzWrf;
	Fri, 27 Nov 2026 08:48:46 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 28/43] sched/deadline: Restore the owner's period at a deboost in the class
Date: Fri, 27 Nov 2026 08:48:35 -0500
Message-ID: <20261127134846.114774-7-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-234597@kernel.org>
References: <221d9b8a8508cdf0e5f3763606ca4c1faff6ee46.1795646914.git.mathieu.desnoyers@efficios.com> <sashiko-outbox-234597@kernel.org>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Can dl_note_donor_refill() call dl_hold_refilled_boost() when
> dl_se->deadline is still 0?

Yes, for a task with parameters but no period yet. v12 will hold no
boost for it: dl_note_donor_refill() will skip a deadline of 0. The
task then gets a period of its own at its deboost, or at its wakeup if
it is asleep.

> Can this leave rq->dl.running_bw under-accounted when a task blocks after a
> donor refill and is deboosted while still blocked?

Yes, as on v7.4-rc2. There too, the 0-lag time of a task that blocks
while boosted mixes the donor's runtime with the task's own bandwidth.
Only running_bw is affected, not total_bw. v12 will leave it as it is.

> Does dl_deboost() start a new period (or arm dl_timer to replenish one)
> while a constrained-deadline task is sleeping on a non-PI waitqueue?

Yes. In v12, a deboost of a task asleep on anything but an rt_mutex
will start no period. A task that was throttled before the boost stays
throttled. Any other task is left to its wakeup, which throttles it in
its constrained gap, or starts its next period.

> When a boosted task with !dl_se->dl_deadline is replenished after its
> donor's parameters were cleared (!runtime || !deadline || !period), does
> this miss calling dl_note_donor_refill(dl_se)?

Yes, if the donor's parameters are cleared right before the first
refill. v12 will record the refill in that branch too.

Thanks,

Mathieu
