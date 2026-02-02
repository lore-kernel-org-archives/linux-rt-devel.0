Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE41538947C
	for <linux-rt-devel@lists.linux.dev>; Mon,  2 Feb 2026 17:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770055125; cv=none; b=WwsujtVGyg4/j3pI9ptd5KmiZGFoWslfi6evAuWwmQQiAmbAi2gGf11MdGHyX5wfTI3ecUePxiyDWaCNqhjTgzy0v0j3gbhIIMpyBlFeR4Amu3Zz2VuyuHKHGBMysjjVQqWwTjNGZogAlqzv/ElaZn+cf+7VYDW3SlDYlqpZc3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770055125; c=relaxed/simple;
	bh=3UXD7SdUJt1+95TtwMu+fX0hyPcDvUY/7kapVNFDUm4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rq6FDp8Uaz1VHWYAv6acEgtSzVV2P1lINes4trWQ8t0dosZzQbdZy6b3kYClWbQZ12w61ICsmact2ieD/fyFCH8Q7KUo0p4ZrOEzlS8wCaJGr5rf83UbA6LTmzHj9co3PlZz/RZpIRWl5TZxUe/zB/H2JOF902LWfRj79du/ciM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cUswOzmq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HPMDDr/J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cUswOzmq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HPMDDr/J"
Date: Mon, 2 Feb 2026 18:58:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770055121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3UXD7SdUJt1+95TtwMu+fX0hyPcDvUY/7kapVNFDUm4=;
	b=cUswOzmq9SicIKrq1DuKaZenA2WxryHQtyXlS/EuwkHXUbAbFXps6JdNH3yt1D2NwVQv8a
	IfteZgVZY5dnRvJOvLLywMZ5K9sm7F6qHD6oj4YcO4VCwRztYT27h4YblUk5z0hbhXtHkY
	5xY6ZSTJrxAg6sgYSzyTdF/BKeP7tmsu0GEcg/0mLxg0vBlXGLdQRThj4VbaMkH+0XbJTH
	QR7N1WDGK/9vVCJdUc7HCd9XH+whAB2V0jGFr8TQuAqyI4SbKFtj6kpQdh5gDl2WT90BY0
	ktN2B079dCcYLLfSFZDUoX16bNnHEYW/5343FIjjqyJHn7dQKni0FtZZ0hCa4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770055121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3UXD7SdUJt1+95TtwMu+fX0hyPcDvUY/7kapVNFDUm4=;
	b=HPMDDr/J3pNjlFM/VG6kKLbZA4FWLxFFoqB6SZHnJc/eKAz/5J89ZZTQFJwJwvMb8IXLxk
	ugHyR7pnj79sK0CQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Thomas =?utf-8?Q?B=C3=B6hler?= <witcher@wiredspace.de>
Cc: Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] rtmutex: Introduce __cleanup() based infrastructure
Message-ID: <20260202175840.-IHSZ_Fn@linutronix.de>
References: <20260202-rt_mutex-guard-v1-1-1c078dbeee57@wiredspace.de>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20260202-rt_mutex-guard-v1-1-1c078dbeee57@wiredspace.de>

On 2026-02-02 18:04:43 [+0100], Thomas B=C3=B6hler wrote:
> Commit 54da6a092431 ("locking: Introduce __cleanup() based
> infrastructure") introduced lock guards for mutexes in
> include/linux/mutex.h, but, presumably as PREEMPT_RT wasn't merged at
> the time, the guard for rt_mutex was never created. Do this now so this
> infrastructure exists for rt_mutex as well.

Wait, what? rt_mutex can be used independently of PREEMPT_RT.
I suggest you focus on what this patch does in its description and
repost it with the locking maintainer in Cc.

Do you plan to have any users of this?

> Signed-off-by: Thomas B=C3=B6hler <witcher@wiredspace.de>

Sebastian
