Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794584263;
	b=IWooXaBmq5pAgTY2/CFlaR1C1/EjGipmmcbh8d0iA29pV3G7qqn6FWTmvHWXSL9Oiaxa
	 lYdanZRYpBmc+dUHeS7Khq7AhdYXpndnYzh642ALVE2Ev147Fv6iFIa3/3IOAqF0RGxV6
	 yZnj4lMSCwgm+RUWdxfUKA+5SVKiRXv7+115F+fBp0mb9nnPOgHevRHG1t6+IGLRJXKwb
	 OHCsLkphjlhMUbL4dk0TOVRUQvxAXXkXCYmqV+/7xz/SreU1GfvxY4ruNFFKwnhdqExtW
	 Q9bb5K9u+ot0LjdlSOu8ipSc0YQeic6yVmZfPW7FuWI5POa5oclSdf6MsDP6nAyYKfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794584263;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=vBC6RXkAf/AjEZXgi+ui8UcYhehpMG1P6b4dQ5IxtmE=;
	b=KSoHkvEgbM7WFqRmIAOoljKkbVsKhVpm6jiZMfJ9o2ZUlaJD3AfS+I3RTOQSOMqhxOFR
	 rqBvx6cgbAWKE3VSxU8bkLrl7KCUoMmw0FG9BPJCr5fMeAiV5JTYIEy0dPnoZCYduBmYS
	 mH/Ty/v2CdmR7Rjx8hMGF6ddGA55uxn/VNoFGnVdTTd4zYITxXzscbfCMB2zqugiI6tyI
	 4ff52uXJOIL6T34nQR/o6grbD2nefuyLSb7RSmUvds50tiAJYPQKoeFtY943pnlhfi4RL
	 M5MDBW3/SKo1LX+2xqRMbpUcjh3JUpoUmqN7GbF40QGRXdLaZ/I9dwTxMUVVI7zIQnw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=jJiaWfb+;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=7N0ReMXw;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F3C606A894
	for <linux-rt-devel@lists.linux.dev>; Fri, 13 Nov 2026 15:37:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 26F3C606A894
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=jJiaWfb+;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=7N0ReMXw
Date: Fri, 13 Nov 2026 16:37:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794584259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vBC6RXkAf/AjEZXgi+ui8UcYhehpMG1P6b4dQ5IxtmE=;
	b=jJiaWfb+UzcZ7/JNqGocTj01z3o9jZbWPV7YmyT/kRIUApa7/sZL81+BT8rg0DydyE8RtN
	bIo0NX4R0TXFk+WYLqWBvxKcsDhrp8iy/0c+/V9C+1ersiFg4ZAOVT7VfU2sCczcSq4acS
	YF/W0tGJRpAkrhNbSJnjvKkrBgc71v6jN2apPCX9mUmZKNL5VuQaia2/4Jujv+O5NntjXn
	8lqeQWRF4X0ZEdqi89r9IwAvRC2hXjJsrPMee8oPb4TJZBGNW6cBUZVTon7QSuWCsKSWRT
	vI6fsOX5ARdm1OLxBstIb709kwfiIBBHWypCPXl5TXCOu54AuN4jpkoVGLAb8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794584259;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vBC6RXkAf/AjEZXgi+ui8UcYhehpMG1P6b4dQ5IxtmE=;
	b=7N0ReMXw/tSGZrpyN02tIeDkHWCNWuol3bVzrhut0zlIuUDe1t/3RuulJUknmdFyz9QcbI
	ZK6uRNiwvxAPy6Cw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Andrea Righi <arighi@nvidia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	"rcu@vger.kernel.org" <rcu@vger.kernel.org>,
	"linux-rt-devel@lists.linux.dev" <linux-rt-devel@lists.linux.dev>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>
Subject: Re: [PATCH] rcutorture: Don't try to disable to RT throttling.
Message-ID: <20261113153737.cXtBKIEl@linutronix.de>
References: <2fbdb03e-1af8-489c-819a-7e3c7b0ed1be@paulmck-laptop>
 <5970553A-3833-43F1-A013-21757664FB8F@nvidia.com>
 <auzXjQfYXs_gzx1y@gpd4>
 <c81d8243-c130-44d8-bef6-e678ecb088ac@paulmck-laptop>
 <20261106140401.90MH_6qt@linutronix.de>
 <5f5ffa5b-9fa5-4359-87fc-7558f37ff0eb@paulmck-laptop>
 <20261110080942.QxKXirzI@linutronix.de>
 <e58e48c3-ac62-40cd-b5d3-2de87db12496@paulmck-laptop>
 <20261111154319.2Iu5wbqr@linutronix.de>
 <3e7f1b45-7163-4abd-b686-a17f137ecab9@paulmck-laptop>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3e7f1b45-7163-4abd-b686-a17f137ecab9@paulmck-laptop>

On 2026-11-11 09:30:37 [-0800], Paul E. McKenney wrote:
> I hesitate to disable CPU hotplug during RCU priority boosting...  Yes,
> one could argue that real-time workloads shouldn't be doing CPU hotplug.
> Except that others seem to be working towards making CPU hotplug more
> friendly to real-time situations.
> 
> But what fix did you have in mind?

I was thinking about skipping sched_init_dl_servers() in the built-in
case. But now that Joel started to reworking the test, it looks like a
better solution.

Sebastian
