Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442EE3218CF
	for <linux-rt-devel@lists.linux.dev>; Tue, 19 Aug 2025 13:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755609620; cv=none; b=mARX7sorNbbQaFOdsu0zmWQPbNPDlHsFSxkRQJwyBuxVx/OhgBcEDAYh2SAZdxIW17UPxIJJzYXt8E5+r7Uc1hZrvnMDCKMKLDNa/YyePsB+mcMH7+T8s1V1NGxUw0LXzJIHVanRiCvtxkP8jw/ttWBlPqqG/jmqXvem4qvM2B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755609620; c=relaxed/simple;
	bh=XU7co7/IhKC1SFIOJ2ctmYNnp6ZOEwiQt191KNHFDnQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XY9KLjHKAe6lRAtA0lS77eapJKIhh/W25N8MKQ3cg2xhx+v0zlQw0hz5YvYwZb4lizNfu5N9GNfiCIkxlvmsByYJ0dfiOXA2Gfwi2qWba3OHQZh7hfZ1vS9uAqUAtpbT7AqDXSD6GFZta/VE48j/dHqdxwrFWryDP93AvIiLizg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Ms7U26Tv; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Ms7U26Tv"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 1313E40AB4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1755609617; bh=efICgIMOiqQPSZSk5RbTaKUwai8LvnXvLst5MTuVWT4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Ms7U26TvAhh2tBh57lX4Hwcs1DeYm4zZ9Ok8oKOzX9+lHT/N2Cf8fPUigYJMpjKMW
	 GCSbXfwA2rbT7t9vNB4l1m94LO1PcF68hze9LUujTS/Um/WRAWShgel8VAm90JKlZh
	 Kt98LYj63moZuo5wJQ8GTJizaSTGuz+EJPjQBd4p3cb384RK48dq+5XQD+Tm1SOAa+
	 qLno0sJwUQ+CwA5IsrDQQrMGxCfytIsRHGe7yg5ZLZcGkSRp2Lv+GveV4D4gZnrMyn
	 aDaOVfbxq3WK2+JGe++3abZvnlfZlXTzplXtltMTsW6srlieGYrgA7vUMrMct5bfsq
	 2PdvkL/14WGIg==
Received: from localhost (mdns.lwn.net [45.79.72.68])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 1313E40AB4;
	Tue, 19 Aug 2025 13:20:17 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev, Boqun Feng <boqun.feng@gmail.com>, Clark
 Williams <clrkwllms@kernel.org>, Frederic Weisbecker
 <frederic@kernel.org>, Ingo Molnar <mingo@redhat.com>, John Ogness
 <john.ogness@linutronix.de>, Peter Zijlstra <peterz@infradead.org>, Steven
 Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>,
 Valentin Schneider <vschneid@redhat.com>, Waiman Long
 <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH v2 3/3] Documentation: Add real-time to core-api
In-Reply-To: <20250819080358.H9R_64I7@linutronix.de>
References: <20250815093858.930751-1-bigeasy@linutronix.de>
 <20250815093858.930751-4-bigeasy@linutronix.de>
 <87seho8v12.fsf@trenco.lwn.net> <20250819080358.H9R_64I7@linutronix.de>
Date: Tue, 19 Aug 2025 07:20:16 -0600
Message-ID: <87ldnfv46n.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain

Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:

> On 2025-08-18 10:16:41 [-0600], Jonathan Corbet wrote:
>> Sebastian Andrzej Siewior <bigeasy@linutronix.de> writes:
>> 
>> One nit:
>> 
>> > diff --git a/Documentation/core-api/real-time/differences.rst b/Documentation/core-api/real-time/differences.rst
>> > new file mode 100644
>> > index 0000000000000..50d994a31e11c
>> > --- /dev/null
>> > +++ b/Documentation/core-api/real-time/differences.rst
>> > @@ -0,0 +1,242 @@
>> > +.. SPDX-License-Identifier: GPL-2.0
>> > +
>> > +========================
>> > +Significant differences
>> > +========================
>> 
>> That heading text will appear in various places, including in the
>> rendering of your new index.rst file.  In such a setting, "significant
>> differences" doesn't give a lot of information.  Something like "How
>> realtime kernels differ" would be better, IMO.
>> 
>> Otherwise, this all looks good to me.  Did you want me to pick it up, or
>> did you have another path in mind for this work?
>
> Right now this is it. Do you update the text above as suggested or do
> you want me to resend it?

I can apply it and make that tweak if you like, yes, no need to resend
for that.

Thanks,

jon
