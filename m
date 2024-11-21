Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D20084D2B
	for <linux-rt-devel@lists.linux.dev>; Thu, 21 Nov 2024 17:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732208641; cv=none; b=PFxuS/JbtToU90ewHz2U7uNVKnOAIp18087Pb9I4xLgqBMGAV9I5q5OVo7zpQpwfIridAHZYdVPKe8BtjEqsKHvgCyyxQGoGl8kLZ3gMgQVYoHAASaSh+AHaJh98S8ZCsuQA6MZH9DOHZznYdNUZO9w3R6N8/HGl0gpYdINsCXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732208641; c=relaxed/simple;
	bh=gsVeeDT0PE0eLhTaYmgb/vHP3YXOVl/p460fTYStwy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=APkhPSXSpN1N42IYJhRy1xYZ5vGfHz1/rIOzkDmu2P1MPPU0Sp10L5tH8KKyMNlJkyrbWfLmHqN5678fkndCCQb5eDar5RXSoY+RAh4ixvSA78AEwfSBHus59Clruw9rWtOo0m864qeJEyh5ApUSRYofDorGVgt0099LWIZUAlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AnJAzri0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ebDQDwM8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AnJAzri0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ebDQDwM8"
Date: Thu, 21 Nov 2024 18:03:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732208638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gsVeeDT0PE0eLhTaYmgb/vHP3YXOVl/p460fTYStwy4=;
	b=AnJAzri0dx9qoeJHBwWB3tOmHcOe0a4hrBItD55XDsCGfsMjAjYg5GziTQY9h//24SyAjE
	9b+wZXaRVbloBS0ubd01Ard7XJJwnxLoz0CULwMCZpFCfV7MXBCkI7YMASYI//uvr5uJEd
	xUlqs2jhjALy2jODR7he1RTCRslCZR5pwmsDQTAGg3mWd+SRglMx8/Ow6lyTA0xg4InUkr
	oUjAa+xEydfy/IzhwQiVs59736uP2GfcmKOpO6WFzjJeDMY+76UM3lghpYyrhR8oXQOQ62
	QyHESm3Lxlx2GLLjHlp7RdRwH5HBn28FpC8iagliNyrNqEkJL3uC1JukuDGhhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732208638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gsVeeDT0PE0eLhTaYmgb/vHP3YXOVl/p460fTYStwy4=;
	b=ebDQDwM8tFsWvVfHSNy3P3COE0Vq8ZUoQfcFZJ9WbWJi1Hca90syqjqTdaYVb/kvUHWksV
	uZezUUWqJm0XGsBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alessandro Carminati <acarmina@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Clark Williams <clrkwllms@kernel.org>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
	Thomas Weissschuh <thomas.weissschuh@linutronix.de>,
	Alessandro Carminati <alessandro.carminati@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Gabriele Paoloni <gpaoloni@redhat.com>,
	Eric Chanudet <echanude@redhat.com>
Subject: Re: [PATCH] mm/kmemleak: Fix sleeping function called from invalid
 context in kmemleak_seq_show
Message-ID: <20241121170356.eC7f3-1v@linutronix.de>
References: <20241120102325.3538-1-acarmina@redhat.com>
 <Zz332cG45rNSeE_B@arm.com>
 <20241120102602.3e17f2d5@gandalf.local.home>
 <20241120164043.T1JuBALe@linutronix.de>
 <CAGegRW4B5PO0HgY1TvsV_R0hPSa5vHk7f=fy0skMpcy+BT399Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAGegRW4B5PO0HgY1TvsV_R0hPSa5vHk7f=fy0skMpcy+BT399Q@mail.gmail.com>

On 2024-11-21 17:50:06 [+0100], Alessandro Carminati wrote:
> Hello Sebastian,
Hi Alessandro,

> On Wed, Nov 20, 2024 at 5:40=E2=80=AFPM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2024-11-20 10:26:02 [-0500], Steven Rostedt wrote:
> > > The "%pK" dereferences a pointer and there's some SELinux hooks attac=
hed to
> > > that code. The problem is that the SELinux hooks take spinlocks. This=
 would
> > > not have been an issue if it wasn't for that "%pK" in the format.
> >
> > That is missing check and I think Thomas Weissschuh wanted to add it. So
> > we don't call into selinux.
>=20
> Your comment confuses me a bit, as I'm unsure what Thomas is actually
> working on.
> Am I correct in assuming he's addressing a fix in lib/vsprintf.c to ensure
> that sleeping functions aren't called, allowing these functions to work in
> any context?

restricted_pointer() has a check for in_hardirq() among others. This
needs an additional PREEMPT_RT check.
I would be actual in favour to get rid of case 1 for kptr_restrict and
have either 0 or 2.

> However, his mention of "This fix for kmemleak is still needed as the
> pointers in the kmemleak report are useful" adds to my confusion.
> Meanwhile, Steven suggests reworking SELinux to resolve the issue.
> Could you clarify what you mean by "So we don't call into selinux"?

This getting out of hand. By adding the PREEMPT_RT check to
restricted_pointer() we don't call in selinux so the problem is gone.
kmemleak is not the only problem. printk(), as another of vspritf pointer
code user, can be called from any place and would also trigger a
warning here.
As far as "kmemleak need to be usefull" goes: With kptr_restrict =3D=3D 0
then with or without pointer hashing they will be useful. If we need to
go via selinux then it ends as a hint.

Sebastian
