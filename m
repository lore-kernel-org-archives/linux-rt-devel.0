Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=158.69.130.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795787333;
	b=gHRYNNb6NAW72dcnsQ5bE1DYhWJ6lmxMR6DOF6v9ZLJnTBJJb3Mag1w+WY5FyBIh/QNV
	 6XlAYesjrnsmA2xT/RPhkBrq/KPLwfywVjCPOgwUC0AWePMaBE/G1pzqsMFihNfIADb0j
	 Pk83fVq0ROseSeLRuE3iqTIKh0Lg0rAdbjuQSrKFUB+Wbto7dFx3peAP6a2ONXXmn6+HI
	 d+Xdl4EaHoNv8YO8+Xbs3Vc9sO4+173yQN4VtST3muVpQgfKwTl65QiRPJi0yXU85uROG
	 zPSswpZdivzNwCjxfZ5rcsud+1SFqCd//w195PakX9nrxbwq4h4MzMaV22cRaSVu1AA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795787333;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=d1TIME1ipW969qGtLzmhRSD62ocT46zetBQGzZmK6KE=;
	b=HT0KGIu9u0bN25RptTaoN38hDn5cPCoYJAz9/yUUWSwUKepmpOHIQSakx/fuXMvOjL+/
	 uYOfNew0Rw0OZlmUfn6+wtSum6ZwTeW6oM7VTyOcyEyOkGNQCv/RKNMveLVKWwznCYbeh
	 ob6u3lj67qYjWwKhyt+IZj0WGuu/fA2u+sq3MoQtpqjIF14AGQ9kHHuXPs4XlL8c3o0YS
	 no7R2f8EUmD5JCOm0qp5qaFNDLfIxM5k5i6jQnSmQH7dBngd3pClfd3QNCw4S7ICd60IA
	 cVuW51QX6DSc/oXMSKddqplcCdHZgB67u7w1L655llnhTcV+lWK+Yo6PptgHKGJtp5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=efficios.com;
	spf=pass smtp.mailfrom=efficios.com;
	dkim=pass header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=Lwnzv71T;
	arc=none smtp.remote-ip=158.69.130.18
Received: from smtpout.efficios.com (smtpout.efficios.com [158.69.130.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1266606A329;
	Fri, 27 Nov 2026 13:48:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1266606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=efficios.com header.i=@efficios.com header.a=rsa-sha256 header.s=smtpout1 header.b=Lwnzv71T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
	s=smtpout1; t=1795787326;
	bh=d1TIME1ipW969qGtLzmhRSD62ocT46zetBQGzZmK6KE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lwnzv71THt81QlpvKCSbR6a1+UFylGUzhKTHmQw5G8jw8Zmh8zKd5RZofICg01Vnl
	 CatUGcPv8s4cea4ChobOgrAWDZONh9X4+wr+PqVpDs4Dm1wF+22wEI8TLsxK6u79Ls
	 h4OCY0/d8HLuElNcwAawOeJKyQDm7gNKNqfMr4UfNIkMhdI5wKDsEEULl+KlQAnU4K
	 agusTtEi2h1cG6YyXYq9Sn6GcbwousYdenmr34qkqfzJvgse4B/Hvb4o+G1IMmNyKz
	 X5kyFjf4gF1JirBacW2RPCUqM1wymEEcU8DJZmc82VxB3VOQQ/EjlZ6xgXK6NJHURS
	 uCf04/RVyk3Ow==
Received: from thinkos.internal.efficios.com (mtl.efficios.com [216.120.195.104])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4jbZWf4ZmDzX27;
	Fri, 27 Nov 2026 08:48:46 -0500 (EST)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev,
	tj@kernel.org,
	hannes@cmpxchg.org,
	mkoutny@suse.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v11 21/43] rtmutex: Continue the chain walk when a waiter's deadline donor changes
Date: Fri, 27 Nov 2026 08:48:32 -0500
Message-ID: <20261127134846.114774-4-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <sashiko-outbox-234553@kernel.org>
References: <1f5dbe87dcc9405b5848044acbb7381db868418d.1795646914.git.mathieu.desnoyers@efficios.com> <sashiko-outbox-234553@kernel.org>
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

> Can waiter->pi_se get out of sync with the donor that rt_mutex_setprio()
> copies to the lock owner?

Not as drawn. W blocks with task_blocks_on_rt_mutex(), which runs a
chain walk from M before W can time out. That walk sees that the donor
recorded in w_M differs from M's donor. So it goes on, records the new
donor in w_M and gives it to O.

A variant of it is real, though. rt_mutex_setprio(O, M) reads M's
donor without M's pi_lock. If that donor changes before the read, and
changes back after it, both later walks stop requeueing at M. The
window is narrow.

O and M are SCHED_OTHER tasks. H and W are SCHED_DEADLINE tasks, and W
has the earlier deadline. O owns L2. M owns L1 and waits on L2, with
w_M as its waiter. H has just blocked on L1, so M's donor is H, and
CPU0 runs the chain walk of H. A task on CPU2 calls sched_setattr() on
H. "Up to date" means that rt_waiter_up_to_date(w_M, M) is true, so the
walk does not requeue w_M. [7], [11] and [13] are the steps of
rt_mutex_adjust_prio_chain():

    CPU0 (walk of H)         CPU1 (W)                  CPU2
    [7] w_M->pi_se = &H
        unlock M->pi_lock
                             blocks on L1
                             M's donor = W
                             walk: w_M != M's donor,
                             trylock of L2->wait_lock
                             fails
    [11] rt_mutex_setprio(O, M)
         O's donor = W
    [13] unlock L2->wait_lock
                                                       sched_setattr(H):
                                                       earlier deadline
                                                       than W
                                                       M's donor = H
                                                       walk: w_M up to
                                                       date, no requeue
                             walk again: w_M up to
                             date, no requeue

O then runs on W's parameters, with a later deadline than H's, while H
waits behind it. This is what remains of the bug that this patch fixes.
The patch makes it rarer, and does not add it. It needs two locks, not
three as the v11 changelog says. v12 will state it in the changelog
and in the cover as a known limit. A fix would read the donor under the
pi_lock, and pass a reference along the walk. That is for a follow-up.

Thanks,

Mathieu
