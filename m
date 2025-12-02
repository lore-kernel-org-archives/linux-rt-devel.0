Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7A43009F2
	for <linux-rt-devel@lists.linux.dev>; Tue,  2 Dec 2025 11:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764674053; cv=none; b=JMdFSO1KK1+TaYjIi1OzSDzCO+ben3LZWfxiw4lpp8v046oC48wK0fxWIgy44aW+Ez7Z8A5owGjHqxTXUHVGPVPDE2d0G2/PVe84ftoC8eMSQNT4+BeQPWNHwWhMFyvsuU1EGScOeqy9nbVgw2CaUSst4oNP08HRw8FnquxaAsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764674053; c=relaxed/simple;
	bh=bX/BZOrQwuKmc74tVLiNwZEy/eo9FWLx8Yi+lmLU2VE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Js+nZJ7Fk8MJhpLWteBG6xvqpmLUMS1smBGUFKtIJryN8yeeUKh+IEJ8Ha8Mhio++38krM/6iCm3lnQJW1gVBz6n0EZK4sOIFddaZfQv7nlIWLdtMgRmaemA0BaOJHjP/jcfrFnkxovV35MDJix0CRTEA+/cBCMYn1cY7uDnylU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BaT45rPs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xaj2Y02X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BaT45rPs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xaj2Y02X"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764674050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bX/BZOrQwuKmc74tVLiNwZEy/eo9FWLx8Yi+lmLU2VE=;
	b=BaT45rPs5NBIUXlqgF2gyQIYX5PkNqJ+M2UpTZwpAAgyrj8g6kCQzJZbarlUD1ZMx89Aee
	k39w0soDpUPW85Wu695hm2SqxIeBlyMB7BL85dh/xCEXwWXIofYBJbh/LvZL272ro8jl/M
	VzL/Vrrw1P83sx5CMmGlIpPzGTYmmzw4sTp+YoyUg8tRwmQA6QTRjseOi9FpuPxfKpoM6c
	jvR35RLYKjnEUmkHTyUVWy8AxdKYz+qIHADxYfRqVSxWkvtae2rAl2NDk/YxMinQZrDrmh
	4+pKRSiZn9QZjMdbu1H+tskLATCq/jN4X1cg5KhcOrVUH4ZRRXd9PELqUaUopg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764674050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bX/BZOrQwuKmc74tVLiNwZEy/eo9FWLx8Yi+lmLU2VE=;
	b=Xaj2Y02XHT5nCtH8EYllYnsL4KMRFFGu338odPFZ+Yy6djHseDayq0Ye+N2s9qz7jh5J6d
	z6Gc0GGRc8r2TdBw==
To: Yunseong Kim <ysk@kzalloc.com>, Nam Cao <nam.cao@linaro.org>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, Shung-Hsi Yu <shung-hsi.yu@suse.com>, Byungchul Park
 <byungchul@sk.com>, syzkaller@googlegroups.com,
 linux-rt-devel@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Question] Detecting Sleep-in-Atomic Context in PREEMPT_RT via
 RV (Runtime Verification) monitor rtapp:sleep
In-Reply-To: <87fraslu9c.fsf@yellow.woof>
References: <32839fb6-dbcb-4c5c-9e3f-d46f27ae9a73@kzalloc.com>
 <87fraslu9c.fsf@yellow.woof>
Date: Tue, 02 Dec 2025 12:14:09 +0100
Message-ID: <87jyz5kuf2.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

> RV is not a static checker, it is a run-time checker.
>
> Just in case you are not aware yet, there is also Smatch:
> https://github.com/error27/smatch. But I can't offer much help there.

I was looking up something unrelated, and I found that Smatch does
detect this sleep-in-atomic problem:
https://staticthinking.wordpress.com/2024/05/24/sleeping-in-atomic-warnings/

I'm not sure if its design takes PREEMPT_RT into consideration. But
seems worth having a look.

Nam
