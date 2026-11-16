Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845527;
	b=UkprY7fJep6ba8Gy7uQODU+GwwPyrIlIysPQpBEUhYsWDXfgpC9O6KsxlOvSTnhnN+Pr
	 y0zDNzmqKDJNuPzjQkRceeXxlfo4gtF1ynjRO4j2IeN8qUSgUIXWKCQJFr9plTfOgx8Pr
	 gOczkHHxjHIsbZKEy2IMBCjFresXe6Tyo98TQxiRlAeQTveU6EmSyGPUBmVSRCvNpNtDf
	 q2s1ykpeGNQ3bOgG3FBxtQ7FwV0YDMzmjXi1RbQW52b721SsbPVP0MzJK90NGMa13IDk/
	 LfPApCIjAHwX8+7Q+gKEh4SbzdK+9n5yqK5hWCTIF/J+N1lZ9l9lHsh/tDgJJuckpDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845527;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=eMi9ZFhkE0g9eHaFRZ1y6HmO/hbDG1jboX2Mkur63Xc=;
	b=I/vP1U6bCzVkQ83x0E3dB//rLTnBWspwpWwXo89gArm9+Aps2rfmIZYaECq8V9ltQ+sf
	 43GPcxtTb2dyt61M/dhPfzImJx/hbVwemMW0X/duLHqGy3i9tb65wNz/2Du4iSSRzeGSZ
	 D2+eUdEwcdbbvlU4jIjhuyUduGSD31mTLJI248l7OkyQkaixUPPH2piNlG2p7tvj2YvOr
	 5tvXgdrU0TdDKkbbrU5nYEh5aQZ82yXABXfFZ5/4QDm+Mexulb7hqHkQO0NA/Cl3RAv7n
	 QUMFBVXNFdwvmIPWtGQjtV77EbnqXvRL1gqtTdM5EGvwYU8kEataZc4HOxLAI8pzxVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yl+l6VZh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 60798606A31C;
	Mon, 16 Nov 2026 16:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yl+l6VZh
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 71E221F000C4;
	Mon, 16 Nov 2026 16:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794845526;
	bh=eMi9ZFhkE0g9eHaFRZ1y6HmO/hbDG1jboX2Mkur63Xc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Yl+l6VZhpCHqKI1JbRoxDoO7EOngz5CZL1wNeQwFlSc4/hMWB9H2/J+eY2F8l3kqi
	 0i/R2x7PVkYtcMUZ2hsnuAMRRNs+0+V06VTcIiqRA+QKo5QfIVwXj1iX6TkISspfa4
	 0AWSA7MH6avwHyWgXAqsAWxKxjQ9petB3706gDv1+0vO0Zn48mXrmRISXxpS6nCNI+
	 0bb0ZRRMzaipctVput/M4n2ygIEfxmVrGDNekIHaVPRiJV30r/0gcCYhzbz9fkrtoO
	 MM5Tz50cKlqMQzOQ1KUiCAv0FgHdy+3KuE3qPVAuj6ZuB1jUd0Hq/XNRGaWP26udaT
	 kCZcZFtr2Zxhw==
Date: Mon, 16 Nov 2026 17:04:15 +0100
From: Nicolas Schier <nsc@kernel.org>
To: "Ahmed S. Darwish" <darwi@linutronix.de>
Cc: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Julian Braha <julianbraha@gmail.com>,
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
Subject: Re: [PATCH v1 00/10] tools: Introduce a kernel configuration checker
Message-ID: <avspf8UQmUNskLx-@levanger>
Mail-Followup-To: Nicolas Schier <nsc@kernel.org>,
	"Ahmed S. Darwish" <darwi@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@redhat.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Julian Braha <julianbraha@gmail.com>,
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
References: <20261106091922.7560-1-darwi@linutronix.de>
 <avQNdicGzL3De556@derry.ads.avm.de>
 <avWy2r1BcDatzwo1@lx-t490>
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
In-Reply-To: <avWy2r1BcDatzwo1@lx-t490>

On Thu, Nov 12, 2026 at 01:36:42PM +0100, Ahmed S. Darwish wrote:
> Hi Nicolas,
> 
> On Wed, 11 Nov 2026, Nicolas Schier wrote:
> >
> > Thanks!  I know some people who are definitly interested in such a
> > config policy checker.
> >
> 
> Great, thanks!
> 
> I hope this leads to more mainline kernel configuration policies as well.
> 
> On the user-space side, it's one of the reasons I'm versioning the schema
> in v2.  This way, projects like systemd can ship their own kernel policy
> file, and that policy will be guaranteed to work with all future versions
> of this tool.
> 
> So it's all mainline-first; both kernel upstream and userspace downstream.
> 
> > Please prepare a new MAINTAINERS entry in a respin.
> 
> Sure.
> 
> Beside a separate entry for the checker itself, I'll also add:
> 
>     F: tools/kconfig-audit/policies/preempt_rt.yml
> 
> to the 'Real-time Linux (PREEMPT_RT)' entry.
> 
> > Are you planning to maintain it after inclusion?
> 
> Yes, I'll be happy to maintain it.
> 
> Would it be OK if one or two people from the Kconfig side also step-up as
> reviewrs?  Julian? Nicolas? Nathan?

Sorry, I am out-of-time already.

-- 
Nicolas
