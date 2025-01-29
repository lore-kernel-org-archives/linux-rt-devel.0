Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB7119340B
	for <linux-rt-devel@lists.linux.dev>; Wed, 29 Jan 2025 19:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738180547; cv=none; b=Zj7iTTCubgkYD9AzQQDwxBXKlKc6tUVp/syLVk1tUKH5pqya9cJy7DRHAI+M+macrf21TM3D7PkipUpRos97u2kjgCNG5/G60hTp6hl7eR9qTMqQSDNOFrtGVJxqFA/iP3QefEfMQ/B4HJb6ajjS6hJYncR/qXrOjHqgSdMemnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738180547; c=relaxed/simple;
	bh=ydKCCCUGfR8+WTIWPYNbOduqt5jqLRjHt843D1prIdY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lwlZ4cUkFn1oIxLb+qfKbe389ga5Pq5O6c30Kta1Rklkm0RituqE+uQU+NQM1T6i9kVRzFQq41PGzOmNOjY3xt/rLZIb0u1V8D9KWSgOnNCHE7RYYPrEULoC8pFyUmI51Z3arWRN7VjnjFx2taxcG3Ry6r/2s4eNW6KIzw9rTJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2aEjgdA2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QT+dCDzv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2aEjgdA2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QT+dCDzv"
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738180543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=706M8veWflnkfxft5otKyZK4NQrhItaWbGp/S0j9cNo=;
	b=2aEjgdA20XQGovHHmWJNdPKZch3womxjtwp7Cbg0wbRWkQcwX4sa+UOHvLVArbtSAZjNmy
	WJKH6iGfWl4eEnihWF9Ula1NGJ3b2XeHTEyrmifrgOFU7mMkhm0/DyZruCqu5GEkhMhbYW
	6Qg2EBKmPkqkuQ4l1uz7lUnZHdKfg9b2MvlBgAQwd0SLel+yCIcMq5dWm1IINPRKTJZmUK
	9osoL/Dtq4Cmhb0Gm50tQMsj8i6TkBtmpDj2zshCsUJhNw6YI2wAqJtryOd2f6Iw9hkvmq
	hlHuENuWJsLBZ59uOHI0wueQxsY+AQEEcrtxwGgFijOUOQu+C+FndHNmOgbPHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738180543;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=706M8veWflnkfxft5otKyZK4NQrhItaWbGp/S0j9cNo=;
	b=QT+dCDzvYKkGx0UzW2AuzJpIZoZRMqldbBLSRjXX1zuWLiZf64ihPxlXfFuLntELKJNNjV
	+OithyJVXMOkqnDA==
To: Waiman Long <llong@redhat.com>, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>
Cc: John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>, Feng
 Tang <feng.tang@intel.com>, "Paul E. McKenney" <paulmck@kernel.org>, Clark
 Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
 linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2 2/2] clocksource: Use get_random_bytes() in
 clocksource_verify_choose_cpus()
In-Reply-To: <5abcb42b-91be-4043-a138-5d97cbcb5378@redhat.com>
References: <20250125015442.3740588-1-longman@redhat.com>
 <20250125015442.3740588-2-longman@redhat.com>
 <20250129163442.vczSGi63@linutronix.de>
 <5abcb42b-91be-4043-a138-5d97cbcb5378@redhat.com>
Date: Wed, 29 Jan 2025 20:55:42 +0100
Message-ID: <877c6d75tt.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, Jan 29 2025 at 12:03, Waiman Long wrote:
> On 1/29/25 11:34 AM, Sebastian Andrzej Siewior wrote:
>> But all this would avoid having to run with disabled preemption within
>> clocksource_verify_choose_cpus() while having the guarantees you need.
>
> I guess we will have to break clocksource_verify_choose_cpus() into 2 
> separate parts, one without preemption disabled and other one with 
> preemption disabled. I don't think it is a good idea to just use 
> migrate_disable() as we may get too much latency that can affect the 
> test result.
>
> I will send out a v3 patch to fix that.

I zap the topmost commit in timers/urgent then.
