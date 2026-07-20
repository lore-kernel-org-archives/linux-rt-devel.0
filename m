Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77FB92288D5;
	Mon, 20 Jul 2026 07:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784532390; cv=none; b=dHAYEC232rdykEdHLlj/vlYN/FTDyS8MyPp3pPueUsOHQMBM/siEc/cgOMAVzB+iSeke6y6s6+kzAL6X1IYp+LFkFdZeNHMhgx7zNOUb5pObUZyCbEb2w/02TTT/5G7n5J20/7mOyrZm63Vd33rPvsdUkjnyBwt0rnd4WIUcNik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784532390; c=relaxed/simple;
	bh=NLfu1zZb3cgivjqlGxJniHTKK/+w6y8O6b3iMrqvji4=;
	h=From:To:Cc:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RYo3cVHshvpI60Wj42/78URYhL9cozs9FTTJNbUSON4RUxhCbsVf8uj+60TP4NMRx8LfRpN1AE3tpeeutELCBt/Pz2R4Xsm5jdqyK00XiPZrm4Jky3qmkAVjvFuNVxTgDCqUkDnj7U+b/ohR2XkKGwBB68wRfciNzHgt1bxwot0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=fail (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wgd+Y7Ap reason="signature verification failed"; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SiY5FZkI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wgd+Y7Ap";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SiY5FZkI"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784532387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NLfu1zZb3cgivjqlGxJniHTKK/+w6y8O6b3iMrqvji4=;
	b=Wgd+Y7AplyC6F1tBZ0uF8LFpvE+7rDSwvvGGfe57tSOyYGZsThETyxq9xTG8NNKVKFHUyP
	zHdLNPQJyDT+V8sAAPqeqblxMntJpgpDZRXGFyZ/gW7k2/qwEMeTw7vk/tyhV6VcVZsR9E
	l+3Hvo74HfOK6ZKkqefX/lPTHZZqw5AuHGo80DQgCJyUHSodAm1ScmVOMXqufJiJRAl3mb
	1o/bccXaM6uNoQTlMAaF61l+NtgO0PFaMU3DJdyyuPJ6PjofU4urLFKES91ZaAuihSYdx1
	ptcUN/nvVla71B9tX0ljfUQiXMdGXmXrCUW+UaiD327NqrvsIefNLMSj857xIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784532387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=NLfu1zZb3cgivjqlGxJniHTKK/+w6y8O6b3iMrqvji4=;
	b=SiY5FZkIYptmyovpX82BFYgjX7e70Ka0rcDC3R/uBrSnvawEO81cJMSLGSqRuUThuM/ih9
	3q10OkD+Xhl+hOAg==
To: sashiko-reviews@lists.linux.dev
Cc: Kuniyuki Iwashima <kuniyu@google.com>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Cc: linux-rt-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] af_unix: Do not wait for garbage
 collector in sendmsg()
In-Reply-To: <20260718062737.8463C1F00A3D@smtp.kernel.org>
References: <cover.1784268931.git.namcao@linutronix.de>
 <471af098e92e7171bf828f619ef6b309b97eb618.1784268931.git.namcao@linutronix.de>
 <20260718062737.8463C1F00A3D@smtp.kernel.org>
Date: Mon, 20 Jul 2026 09:26:26 +0200
Message-ID: <878q76f7fh.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

sashiko-bot@kernel.org writes:
> [Severity: High]
> Does removing the unix_schedule_gc() call from unix_prepare_fpl() prevent
> proactive garbage collection of cyclic AF_UNIX file descriptors?
>
> If a long-running application creates a cycle of AF_UNIX sockets and closes
> its own file descriptors to them, the cycle maintains a positive f_count.
> Without this call triggering the garbage collector, the uncollected cyclic
> sockets could accumulate until the application reaches its RLIMIT_NOFILE
> quota, causing subsequent socket operations to fail.

Yes. But an application that creates a huge dead circle of AF_UNIX
sockets is already shady.

And keep scheduling the garbage collector can cause CPU consumption for
nothing, as shown in the v1 thread.

> Additionally, does this change leave the user parameter logic in
> unix_schedule_gc() as dead code?

Yes. That is cleaned up by PATCH 3/3.

Nam
