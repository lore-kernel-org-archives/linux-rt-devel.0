Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D663D7D83
	for <linux-rt-devel@lists.linux.dev>; Wed, 25 Feb 2026 16:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772038798; cv=none; b=PCzX6OcZ3p87mTi2D6WGg1GFrogIQ8VV6AA6FxhO/qeSszUspXegC2lWSBZs3Hku0C3ZP3R4NNJGuxnu5xnV2E3K1NkmZlYRMqNgQJPIN4m5DOrol7s/HyWRMzPrjZvfK5U046PSgbBDe3Pi9Jmfli709kYOZIjvE48gVruuvrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772038798; c=relaxed/simple;
	bh=E+PFY3KJ41sWn2EAoDPd8bwCo4o7mOgES37Xa7Rl0JE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHMgBAC9KsiObdGEP77HZaH+/50qHHVz4GwZpBPiRymMedZWUNOPNVmR3s9nEp0WrLI/UenkFibvd9LH0+fb7HBGokbhpV/itnikgLW8D7mryNHQ1LZxRyHS8D8/j0dDgMo79Ledpu8OFbsrEpleGx4uSxMu9qdEXmtUB/3t7p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KKmjekFl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ep0cYBTj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KKmjekFl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ep0cYBTj"
Date: Wed, 25 Feb 2026 17:59:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772038795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KxkawXcqlJEdwsRv02qGmm0KC1QlDfGnzfXeShzLCiM=;
	b=KKmjekFlURlIb0tLBLm/mV4m2cXvqSukb0DRhea0RCqoCPiY9d8/YTTi10/oCjaMU3YstJ
	MwOubMIFliFtUhiyBqj1F4ZMprKEXYwQhMSkavJoQHPCjF+WSx7OJQPKJU3nuIU1Mo7j0X
	ipUswu+ShFN2023HC6KgIZeM4Y1nlLlgY8CoJTA4mQDLVFjEsao0/muP3xaNzZJacScwTj
	IUF6F69sYhl6naQ56jvl/+3JNmmCz7dnbzBstlLu2cmkksVYyScurfj6DVysA0LRn1umuj
	ZsSKUutLY2OJ+vGxOAmv/5SVvCHwUgdKDvdja9LcIleEVJNb0CizL9DQu+lqMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772038795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KxkawXcqlJEdwsRv02qGmm0KC1QlDfGnzfXeShzLCiM=;
	b=Ep0cYBTjLIy2X+dYnYcP7OSME0abOwsobgQ3OH6o2//37bo44g6NXDAL47nVvX/8sy15wE
	sP5YT8B2R25J7QDg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Bert Karwatzki <spasswolf@web.de>
Cc: Tejun Heo <tj@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
	calvin@wbinvd.org, dschatzberg@meta.com, peterz@infradead.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: ~90s reboot delay with v6.19 and PREEMPT_RT
Message-ID: <20260225165954.180aRkaV@linutronix.de>
References: <aQufmyZ7X7NdfiCL@slm.duckdns.org>
 <20260219164648.3014-1-spasswolf@web.de>
 <20260225154341.32AjXoVi@linutronix.de>
 <6abee0b4bca811680a7f7fb6ab70bf27c6805cf5.camel@web.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <6abee0b4bca811680a7f7fb6ab70bf27c6805cf5.camel@web.de>

On 2026-02-25 17:37:56 [+0100], Bert Karwatzki wrote:
> I've done two testruns with this debug patch (The persistant log buffer w=
orks now, thanks
> again to Steven Rostedt):

=E2=80=A6
> This if from PREEMPT_RT log, there*s a long pause in which cgroup_task_de=
ad() is not called

Yeah, I don't know why. The irq-work is invoked slightly delayed so that
part is working.

| irq_work-24        0..... 1501734us : cgrp_dead_tasks_iwork_fn: Kill ffff=
888101588000 (sd-close)-1964
| systemd--1         1..... 1502194us : sched_process_wait: comm=3Dsystemd =
pid=3D1963 prio=3D120
| systemd--1         1..... 1502547us : sched_process_wait: comm=3Dsystemd =
pid=3D0 prio=3D120
| systemd--1         1..... 1502771us : sched_process_wait: comm=3Dsystemd =
pid=3D1964 prio=3D120
| systemd--1         1..... 1502819us : sched_process_wait: comm=3Dsystemd =
pid=3D0 prio=3D120
| systemd--1         1..... 1502835us : sched_process_wait: comm=3Dsystemd =
pid=3D0 prio=3D120
|   rcuc/1-31        1b...1 1524116us : sched_process_free: comm=3D(sd-clos=
e) pid=3D1964 prio=3D120
the gap

| systemd--1         3..... 90610397us : sched_process_wait: comm=3Dsystemd=
 pid=3D0 prio=3D120
| systemd--1         3..... 90611469us : sched_process_wait: comm=3Dsystemd=
 pid=3D1829 prio=3D120

So for some reason systemd stops killing tasks. It complains about still
running gpg-agent and ssh-agent but both are long gone.

Sebastian
