Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C511A23B9
	for <linux-rt-devel@lists.linux.dev>; Mon, 30 Jun 2025 07:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751269906; cv=none; b=HW/uk63Ga7gJcQuw5PCv7blFX71cwOxM/DCK8z30f8EOS2OFxun9GZ6xgZhOWaXSnKDwupxXQjQ1V4+Xzl/WVhWu5WoBnjKfoPXAgUeOXUKcXFpW5X9f+7ouK56CKe8Biu+gHYa3W0qN7q5QrNsJ5BCl2hfOl1JgzPXKWXQe0No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751269906; c=relaxed/simple;
	bh=xn+NBUB3+Mr9eTfCufBumqgrMD8cHfV6rSFm773YE8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Adxil2VX48heQIJQXk45Au2yQ4UcILACq5Q9jkMG7c67NBz6B3kJMHRXDyo9Mhk3DcKm0+YAxN7L+zM+byayga/mhmU2/v+pGfevr1hHVY9+QOl2wZQ5ASWDuXBIVZ78pKyLBItFPzFDiT1bVTGcdk87lvQLa4LO/WG+8W00bPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wT9oeIdV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0eBA3ENZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wT9oeIdV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0eBA3ENZ"
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751269902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9suz2E9pzgU6m66TDH8ig9aH5KogCRlvK7vYSiwCuaU=;
	b=wT9oeIdVIfnTT7GsXDSYL7qwySmnb2f79FqTWAIH6OTASlTTrKMFhHlukZUmZy6/cGv5uN
	nE+Tf6PnvZ5aIt8KP/NiVTMzffuik0M2hI0UcmjtL6cEkAceXVOrd38KWIhhHAmiXEx/mU
	0ZHa0F31fO/Sku/s3DHWai9JjFXiXpCuv9WdKJIEmzq0uR6INBgZzezwZvangxGfKhCgG8
	z7LClb0O9zADPT6U97pZPprrBPnH10YTQ5AvFZeI/VKFTS8aBJU/3+tVGjXBgEwLv0ycDU
	OiyQ+a7jYX69Q4zL1V5rrOJWPccNFTF47YxTkE0kRwBG07yQiDR6IZ2y7Eke+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751269902;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9suz2E9pzgU6m66TDH8ig9aH5KogCRlvK7vYSiwCuaU=;
	b=0eBA3ENZQDT9t8ulsvL03SU7XR6j2wfXuaDgK4cYaJLJ1a5X2z+Z2lmucC2T3891mbkjdj
	x4Gpteuh2/OsrNAg==
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
Subject: [PATCH v3 0/1] local_lock: Move this_cpu_ptr() notation from internal to main header
Date: Mon, 30 Jun 2025 09:51:37 +0200
Message-ID: <20250630075138.3448715-1-bigeasy@linutronix.de>
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

v2=E2=80=A6v3: https://lore.kernel.org/all/20250610110205.1111719-1-bigeasy=
@linutronix.de/
  - Properly align the trailing backslash.

v1=E2=80=A6v2: https://lore.kernel.org/all/20250514110750.852919-1-bigeasy@=
linutronix.de/
   - Repost without the crypto user.

Sebastian Andrzej Siewior (1):
  local_lock: Move this_cpu_ptr() notation from internal to main header.

 include/linux/local_lock.h          | 20 +++++++++----------
 include/linux/local_lock_internal.h | 30 ++++++++++++++---------------
 2 files changed, 25 insertions(+), 25 deletions(-)

--=20
2.50.0
