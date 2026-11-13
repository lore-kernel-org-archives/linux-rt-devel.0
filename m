Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794586660;
	b=UAR+NC9HjL8Dv4Vl1CNpt6CG4oSmmiIyBef85oDt8eQQUnK2tsySqq/2Uh55cZVulV9k
	 Os5X/MCd7wFLXfVaeKp70n/V6YRSn81jHXMTqc9g8SjG43EWWu1XJJ4z8cAzn6rPhmR9D
	 79/B2I+QgI7iSiubWpqteFoFDaZJF1yvqu1gf7qEP0gMyOW+iZUND2llJRaKUZFcA/YEs
	 OorK3PQ8SfNYbwa9NGL0a50oy/2gy9AKdo7fEH4jPbOXp6zW0L/aHd/0gSXq3gjRBdxiH
	 +pkH6KO5cwQ427D5reUzXhuHKgV3Om/h2LbXeZ7mh0ZKsOwcezK4fyJ3q+vEPKoZM6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794586660;
	h=DMARC-Filter:From:DKIM-Signature:DKIM-Signature:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:MIME-Version:Content-Type;
	bh=YmKdqa9PN50e2UkKt3EfBiqD0YdHB3OU7Jqo14mmKwc=;
	b=QLrA+JCPliu2M3UqM0IB0Qob9YuRGjq50VpdvmjuVj5fRDWIIpeATeW+oOozwf/K+mWj
	 EEmmgRUXPTvlTqkJzlMqLCsquLCLF0raZAQMT06ad2jIRrgI01rRDdkR+JlzurOawz4Ob
	 GZdLoi+ziVhx3qArwTcA9AKeR7OhYunW5xpN3gOvIf2LkZ+/ITDdavcqPvQhyhm0QlJbr
	 oxqL5Z01S2KVr+A8P4Vy8AkQuBilP7uKoQhYHa78o65sskUS0PFIy0/eOP/68QQPtvO2t
	 rktoE70bmGyTl/63PurYYN7zgBLYsrvQUp+nGyQMY+V080/mkBbHJCK5X957H1ZePnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2re49ded;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=joVtIRfd;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A08606B2C9
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 16:17:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 51A08606B2C9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=2re49ded;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=joVtIRfd
From: John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794586657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YmKdqa9PN50e2UkKt3EfBiqD0YdHB3OU7Jqo14mmKwc=;
	b=2re49ded+Le750cmPbDqpI3zJEZ/u0Oc7eONWJd3Qs/wtWtK95vs/WF8CGMR/eXxk4XVxy
	vBmdimlh5qDREKfn+ZDsJcpUO5asyP0EFbiPqTymVB/ifkj8SLDM1tYEqdyn49+lT9njUx
	Cvyca1ho1k17KvAYgKwuiWa7RJt6so0FJNZxljAqhQtYLRoa0v9k7L5mQEKI21ignQ9SLY
	RiFFLObI/YzTSciLd3SyhqndDhv/JlsPfP2xpcoJ/NoKebE6MuCZlYk9GLE66fIpEx0raR
	KAC8L6eMZDsH+XVVxed0tiUc9WoZXOhH4UcRiwp60bypCM/93MOcs0KzEzhqGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794586657;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YmKdqa9PN50e2UkKt3EfBiqD0YdHB3OU7Jqo14mmKwc=;
	b=joVtIRfdyNUPxYkkHCdBB1CAhkPjdGqwiluEKQIbr3TaCE7+KYxzMSj6Rw5thx1FJyuZzU
	Tczgj9z1Yp0y12DQ==
To: Tomas Glozar <tglozar@redhat.com>
Cc: Daniel Wagner <wagi@monom.org>, Steven Rostedt <rostedt@goodmis.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams
 <clrkwllms@kernel.org>, linux-trace-kernel@vger.kernel.org,
 linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH v2] rtla/timerlat: Lock the memory of the user-space
 threads
In-Reply-To: <CAP4=nvTswKUTSJiFRJK7KXAvc3JMLDCgXW=mSV6BO3mMucyWnA@mail.gmail.com>
References: <20261113-rtla-mlock-v2-1-14382f140da0@monom.org>
 <87o6bswzj9.fsf@jogness.linutronix.de>
 <CAP4=nvTswKUTSJiFRJK7KXAvc3JMLDCgXW=mSV6BO3mMucyWnA@mail.gmail.com>
Date: Fri, 13 Nov 2026 17:23:37 +0106
Message-ID: <87ld6wwvry.fsf@jogness.linutronix.de>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain

On 2026-11-13, Tomas Glozar <tglozar@redhat.com> wrote:
> The only other activities the user thread performs with RT priority on
> before entering the timerlat interface read loop are setting the
> cgroup and opening the timerlat interface file descriptor. I agree
> that ideally, setting the priority should be done just before the
> loop.

If you say it is ideal to do X, then why not do X? Real-time tasks
(especially running at rtprio 95!) need to respect other real-time tasks
on the system. Developers new to RT might see this code and copy it. The
code even has a comment:

"If you want to use as base for your own tool... go ahead."

For me there are two issues here:

1. RT latency measurement tooling needs to be a little intrusive to a
system as practical. Otherwise it may not be possible for developers to
use the tooling on their real environment.

2. Official RT tooling should set the example of how to program for RT
Linux correctly.

John
