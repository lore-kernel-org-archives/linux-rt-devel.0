Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68E4538E8A8
	for <linux-rt-devel@lists.linux.dev>; Mon, 20 Jul 2026 07:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784532371; cv=none; b=bOtmVdCcuTplXij5m1ecLRWXQcI0nJ3qx5Zu09NiSYK/3tFp8A3HxFV2Cu44FMx2Bv9oMsvwVUEaMhNRkAsZkfh1+T3fZGMFnKD42SwgQn+HbVDJs1tUst36NzvrvIRXvLgbTNro/x5w/nW1UIiiSO6wS84+2DYWdBponfi2KYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784532371; c=relaxed/simple;
	bh=UOIkjNoxbfIFYVHLI4yFssH6Y/D7YgIxGoQqmFG14oA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t/6OWHD9whs5vpCRMlKgq9MM345hB6JmWn2MnmgpPiZNEOE9TS8gUHSLdSyxIobH17NwiTfpOOH/qhSqMukftCUUfSw5tfMh73/laWDsUGSJ/GRcJA/3p1S8n9P+J8v024UI1jy5MOZcsVDPp6/1twn8D4Ktmwp9OwOnLJEov0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QJ/OLNIy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7MJS/yYa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QJ/OLNIy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7MJS/yYa"
Date: Mon, 20 Jul 2026 09:26:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784532368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UOIkjNoxbfIFYVHLI4yFssH6Y/D7YgIxGoQqmFG14oA=;
	b=QJ/OLNIyW/TJH6J6PqTmIYtUt9lmVMlIdgree2nKfMNGTc36QnTnHmf+sKdvE027+YDb8M
	1UQQpgFpcfcJ1MHRAktDNuoTd5WolIjay8KqgS2tyMu/09fD1PYaMTEYLXAEsF25IyRgAY
	UlLzkl1ZCqFBPHBl0Fc5jr88c5wdZY9ZxEnBQa6YwlfQKoLed31SMWKYMU8QbXbmgszL/i
	4ogU+9lctCBtAriK35nHSaQxNdnUiFNaSnbhIO/NJB8Tc5r9OuZQ7p9DC7QA3Hvx2iRB+g
	LSEcFjdoJcJ4z8T0ovUjFlAbSWhkeE51tQT8uhOsSuNkN25Y3B5b1roLaHUpTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784532368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UOIkjNoxbfIFYVHLI4yFssH6Y/D7YgIxGoQqmFG14oA=;
	b=7MJS/yYaGQqNlruweePnxz+qv2CAtkdQic4wCsA+gkGoVgGutUGPHgTgTXLeXKBaW9mZ0f
	y/l5ATAdtkpM4YAA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
	linux-rt-devel@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] ARM: select HAVE_POSIX_CPU_TIMERS_TASK_WORK
Message-ID: <20260720072606.8KxzuDAj@linutronix.de>
References: <20260718214515.11275-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260718214515.11275-1-kmehltretter@gmail.com>

On 2026-07-18 23:45:15 [+0200], Karl Mehltretter wrote:
> Commit c6e61c06d606 ("ARM: 9463/1: Allow to enable RT") enabled PREEMPT_RT
> on ARM but did not select HAVE_POSIX_CPU_TIMERS_TASK_WORK. This leaves
> CONFIG_POSIX_CPU_TIMERS_TASK_WORK disabled, so CPU timers expire in hard
> IRQ context.
=E2=80=A6
> Fixes: c6e61c06d606 ("ARM: 9463/1: Allow to enable RT")
> Assisted-by: Claude:claude-fable-5
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

> Found with a self-hosted syzkaller instance patched to fuzz kernels on
> QEMU's versatilepb machine (ARM926EJ-S, ARMv5TE). Runtime-tested before
> and after the change on that setup, and compile-tested mps2_defconfig
> with PREEMPT_RT (NOMMU, CPU_V7M).

I obviously got the rules confused while dropping the KVM patches.

Sebastian
