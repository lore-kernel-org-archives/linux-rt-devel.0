Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1A73AAF46
	for <linux-rt-devel@lists.linux.dev>; Wed, 29 Jul 2026 15:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785340167; cv=none; b=h3FlKFgwky8FMtzF7PSz54FhTN9uHEM+M4HBhsB5g0iXwQkYuYfvI4mVu1kgYIlLi/vv1qh2fv0FKJuIgfrL1UJ7OSOU6vztDIdVrG4RX35J8dc9uIMICvD+q+x1bqotp0TZ5PC9avVc4WRfylsINsveJLxgS+wZKDLmwUfLMzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785340167; c=relaxed/simple;
	bh=SOC4QIZJSfQe/L7NT/oqxy0MjU8h23wUbA0I6Q8bHlY=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=W1y9xUKj4peiHUhUoG8/Wy2NyZfwfvNhmN4jy2sHKIvtZylFQhCOE0Qwlf+YXodUgdsil+00VPx8u+2nWfcsAK62etCJsqks9UhNAdFjfRZR4apWkBkelmbMBpF+EGb/nkuRp3sM/YNwV+YtTt6d6Ax6jjxRajeRKWH0sHTrn1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yTdIg9fP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+2kld2fc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yTdIg9fP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+2kld2fc"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785340159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SOC4QIZJSfQe/L7NT/oqxy0MjU8h23wUbA0I6Q8bHlY=;
	b=yTdIg9fP02bMm0o0Jys1ZebE1xvInw69onAWWF2ccEGaeYuotDCbHaZL8/seffAbil33gQ
	65jqDKxqowTW4uw4/rMM0CRN77okdxoj9TnDF3SpZNMHldnfjb3CApupY/bRrO2OOqKxVd
	SRUuWDVQMtc9K/yUkhlDwcryq7nc/X82HtE5S48PD1QKGOsYqmUBZWZYwhlTljqQ+pDnkz
	BHg/5zeZ2q5VOG2opr8+ONe/KB42xVwAcmmlcUZbbULC3pbaLxaB+JVnte8X9JukpYymXI
	zuIhZ/T55fkaloc9v1dbg28Yuusg79SzhXEi5pr7Lv4J9wGZQ8FEBzqUgnc86w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785340159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SOC4QIZJSfQe/L7NT/oqxy0MjU8h23wUbA0I6Q8bHlY=;
	b=+2kld2fcWxkZHJCZzyYFV2R6GspHFJvHJ0nJ/Ez9fz3OUKZr/I28XxD5RJ6FnLOaXWZqyu
	bCfa7m5/dRbdbqCA==
To: Paolo Abeni <pabeni@redhat.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon Horman
 <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net-next v3 1/3] af_unix: Schedule the garbage collector
 at task exit
In-Reply-To: <e9709a13-9fd9-4ee3-88b0-9cc56a1ca07c@redhat.com>
References: <cover.1784712370.git.namcao@linutronix.de>
 <ba4ed2717e5225b7b77ef928fb97ee5544632811.1784712370.git.namcao@linutronix.de>
 <e9709a13-9fd9-4ee3-88b0-9cc56a1ca07c@redhat.com>
Date: Wed, 29 Jul 2026 17:49:18 +0200
Message-ID: <87wludx0ch.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Paolo Abeni <pabeni@redhat.com> writes:
> Sashiko noted this can cause relevant regressions:
>
> https://sashiko.dev/#/patchset/cover.1784712370.git.namcao%40linutronix.de
>
> Generally speaking hooking the unix GC at task exit time does not feel
> right (layering violation). Perhaps scheduling the GC with a reasonable
> timeout in unix_update_graph() would be better?

unix_update_graph() doesn't work. In the reproducer, the sockets'
refcount do not drop to zero and unix_update_graph() is not called.

Thinking about this again, I am tempted to add a close() call back to
struct file_operations and we schedule the GC (with some timeout) in
that callback.

Or we can also periodically run the GC. Or we just ignore this issue, it
is capped by RLIMIT_NOFILE anyway.

I don't really like any of the option. If someone has an idea, please do
let me know.

Nam

