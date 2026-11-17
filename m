Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794917710;
	b=128rNNhnqxWmcZ7RAdtna15kdrgblodKzn6gNoUOYGQ2QPo2SoFAwJURfvtGX04lziTt
	 nr3Z83atb2zCVG3G1J26/piYsehXLJC58h8ztWMUj6XAY9lcxebJmx87UgvY3UkDLRHbg
	 HTjDE4YeAGRO8Lz8G7FPG6lTUdZ0cGqEs6sXe4jI7adKjhVs48j2LYuC4wD2/3aXUsAaC
	 iU0tX6Y1qJhCBrJ96UNhFpTfR5u6IB+SWP5vA29TmRQc6XHqEyySVrrLHeu54YODixypQ
	 DG5i5CXTbhWNaqcRC3kiIwi9yXvYwwaemXkI5mBc0faVJJAqla3XCF2f9SwgoOjonuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794917710;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To:X-Debian-User;
	bh=AlU8foR46Ew+9sYrPUg6ytc9IM26mwN502htmU9Qc8o=;
	b=og0ceHdxv5hT5wQeHkQLITt+WcjNikS7D6HF98LB2916lGbO6e1HQQbi+c2s1+Hhr70u
	 bagsiu6ZOFbV33Io/Q9plQk96lHPrmlzGLiB+HMPg1eV7I1Qlentas/fCrGZLiyZ2DiJj
	 dkHmyjyALnqa2PzZ7Jbp5wMKEA/rTSddBcHKpPyyWFXI7PISVbQV5ISxKwmD3m0Hy6hdz
	 DUZwbZSYXQgebDeFhj7mGfOsEfb/8HbRhGZnRbeyY+4tmELlJwfKJMmNWuLRYWeK1Sb46
	 cMNMRIerfUA4zlAygVNkJBKmUHB8sOMSqsTYFvomJhPgvqYXX0U4FXOd41IWJx/LMHA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=NR3epSKT;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C145D606A32C;
	Tue, 17 Nov 2026 12:15:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C145D606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=NR3epSKT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=AlU8foR46Ew+9sYrPUg6ytc9IM26mwN502htmU9Qc8o=; b=NR3epSKTlJPk5JbUxeBAi/Wvd1
	Z5uI42Qqir0JDd5nHLRneNBfXPk3CAUeAzBIFBduA86QDEQ8AI3AZTnsxxF+bgYH7NAyW3sG5mqQe
	szMJdj6qH7ZA6BMH3iPiXwfgmtRULmo8yR4O1O7xM+ynx4LYbnNQrTuUnPJkSgNoSePfKEI+yLwJM
	9g/C+uxcwCNldwM7NKOMSQjCL5+/1ctdQgus0ajQq6FKKujZiPqly87C5T/QdA+CItqrq+BLAwtX8
	tBuzHXTGqmqaiiSzk9eOo809xzO3NBfyji1lmCjQ9b3MGn2VeChb6niAvcgjcjtG6+7qTPgwe7NWX
	IhjZZueg==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <ema@debian.org>)
	id 1xTI5Y-000WV3-1m;
	Tue, 17 Nov 2026 12:15:04 +0000
Date: Tue, 17 Nov 2026 13:15:02 +0100
From: Emanuele Rocca <ema@debian.org>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nsc@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Frederic Weisbecker <frederic@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	John Ogness <john.ogness@linutronix.de>,
	Derek Barbosa <debarbos@redhat.com>,
	Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@amutable.com>,
	Daan De Meyer <daan.j.demeyer@gmail.com>,
	Luca Boccassi <luca.boccassi@gmail.com>,
	linux-rt-devel@lists.linux.dev, debian-kernel@lists.debian.org,
	linux-kbuild@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 02/10] kconfig-checker: Introduce PREEMPT_RT
 configuration rules
Message-ID: <avxFRmhBrlKLtQ97@ariel.home>
References: <20261106091922.7560-1-darwi@linutronix.de>
 <20261106091922.7560-3-darwi@linutronix.de>
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Post: <mailto:linux-rt-devel@lists.linux.dev>
List-Help: <mailto:linux-rt-devel+help@lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
List-Owner: <mailto:linux-rt-devel+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261106091922.7560-3-darwi@linutronix.de>
X-Debian-User: ema

Hi Ahmed,

thanks for this useful tool!

On 2026-11-06 10:19, Ahmed S. Darwish wrote:
> +  - name: CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE
> +    expected: y
> +    severity: high
> +    docs_hint: config

The docs mention the following for CPU_FREQ_DEFAULT_GOV_PERFORMANCE:

| This is not an absolute rule. Some setups might prefer to clock the
| CPU to lower speeds due to thermal packaging or other requirements. The
| key is that the CPU frequency remains constant once set.

Yet having the rule "severity: high" will presumably make
kconfig-checker require CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y in order for
validation to pass?

> +  - name_pattern: CONFIG_CPU_FREQ_GOV_(CONSERVATIVE|ONDEMAND|POWERSAVE|USERSPACE)
> +    expected: n
> +    severity: medium
> +    docs_hint: non-performance-cpu-frequency-governors

Similarly, by reading your docs, it seems to me that the worst choice
for RT workloads is ONDEMAND.

| The ONDEMAND governor should not be enabled on a real-time system. Its
| frequency changes depend on workload behavior and can significantly harm
| determinism.

Shouldn't the severity for the CPU_FREQ_GOV_ONDEMAND rule be higher,
then?
