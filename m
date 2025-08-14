Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6962E7F24
	for <linux-rt-devel@lists.linux.dev>; Thu, 14 Aug 2025 08:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755160856; cv=none; b=Lenpqn/OgivP5JIFAlNLS7HiV9KcH90RlRZn3vbXSRv7LAyq8KLrQzJ0QqpAqusLwPgGIkU7FOMwFpMWgbUWs7Rxd5hqyfNU3wDE9BM/FkuyhIH11RMtXm/6lxuL+1HunAUVB1SL9x4j2pmpFRKhFR7+kP0ha47g+PfefQ45wAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755160856; c=relaxed/simple;
	bh=EGmdGalmSci7nSZoWt5x2LKRSVMsbV9SrPNPS2/ywi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Uau4LKARYCNMmRLdItlmMwlaQRgdIfy4ENNAddjjyA3WIlINtuuxwQEJ6WapQ06ekgH0RGQIvqMdpuGb1HhCTTTOLqfV6Fk6QQOpemT9isyCDJR5zyhlRcSTa1KH598hZ/MvRYJ3IViJvj19KZIovsxbClF+LK4a54+eaMAZAk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E0tYJUhh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gVhM9bFj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E0tYJUhh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gVhM9bFj"
Date: Thu, 14 Aug 2025 10:40:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755160853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGmdGalmSci7nSZoWt5x2LKRSVMsbV9SrPNPS2/ywi0=;
	b=E0tYJUhhqWGzJkLqlqnrXvx7ycRG9J+diDGQasFLbLXYzs/gzZkY6pqbjfDGvuzLOs5opb
	aumB00UynmDf5h18xIsAomY2XQwdbaF9WyoaXH/Xg/8kuNqsWcyd7U/NYPIVpNaw5k/KGy
	P4sgP50bGJAyciGWri3DXYC+K1vfgf9yKYBwMo9k2Wh0TvCXRK8HbWFVVj2zx/Qnl09/q8
	cHPTr+9HbBqP/BiVLrHk0rhNEbYiXJKob+GRv+/aYhOdlgAuSWhpN5RUnEip6e4e6DotDf
	dWNilAzOlugjXscBlgIldspg9m8sutktnw0QZLif9FKy302dwsjAJOls6slSQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755160853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EGmdGalmSci7nSZoWt5x2LKRSVMsbV9SrPNPS2/ywi0=;
	b=gVhM9bFjRi3QknRLLekuJWfdDbQEEigf5tdJfnp3sqelwXGvx+7jaq6Tkg0tS+Vym4dteO
	Q/ZdeFGp+vY5ADCQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev, Boqun Feng <boqun.feng@gmail.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	John Ogness <john.ogness@linutronix.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/3] Documentation: locking: Add local_lock_nested_bh()
 to locktypes
Message-ID: <20250814084051.QU77fjQo@linutronix.de>
References: <20250715144127.697787-1-bigeasy@linutronix.de>
 <20250715144127.697787-3-bigeasy@linutronix.de>
 <87zfd5dxlc.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87zfd5dxlc.fsf@trenco.lwn.net>

On 2025-07-15 14:10:23 [-0600], Jonathan Corbet wrote:
=E2=80=A6
> > +A local_lock_t together with local_lock_nested_bh() and
> > +local_unlock_nested_bh() for locking operations help to identify the l=
ocking
> > +scope.
> > +
> > +With lockdep is enabled, these functions verify that data structure ac=
cess
>=20
> Did you mean *When* lockdep is enabled?

Lets do "When". I most likely should have removed the "is".

> Otherwise no complaints here.
Thanks.

>=20
> jon

Sebastian
