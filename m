Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53D337FF7A
	for <linux-rt-devel@lists.linux.dev>; Fri, 29 May 2026 17:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780075216; cv=pass; b=jclg0iATwS4JSzUcrodW4n620D0K02bInlkpm/mripZN4mUlUMq7g0G59Hwe4EK3ta0eAcxI9oYtZjAgQ95jk7SYPU4LaUWco5qaWM63GygHw7BS4SYdOnk3HV3KLKp3hAGCVyBhB6FRCe7WFJiHGCUbqV/O7MGUYVrDM9yWNgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780075216; c=relaxed/simple;
	bh=ynZ2XBdbslE1WoArPNQQVVLJB+hS3g1ZlbeqlJR3SQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=heoXYKVHz/k1Ui/vvuiHTUobMaQBxmpE71hsR0xj3wZNp6awdQIGVXv/TRETJ+pJErCFAGzrOo6qynyrPXjCsrH87j4ORb6+commmcUOmjE1pIaWr7z16NXEvrl0krCJ3ABdiIxOJHKa/EnMpdngR+4z4r/9QV8V/DrZbKo4M44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBDtTRoN; arc=pass smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBDtTRoN"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-bcd3c190f71so2241373966b.0
        for <linux-rt-devel@lists.linux.dev>; Fri, 29 May 2026 10:20:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780075213; cv=none;
        d=google.com; s=arc-20240605;
        b=Wv3E037y7cMV7hqTCPeWamZKClyupblZmB+DZsq3JWMPdtPUYyR6ktMl1Ase+D7PYs
         84UIVPs9H7NpnVBMAkr5lyy0wOsr/CKPtvfCxpHpuA4T3mNE9Ph7GXlDCtWAG6PF1gSM
         7B+HpEnuuFnPpaL4pMmYyKC3QfYdLyDrx+PMIUGygI/47oM97+5xdM3qoEG1iqZt8Pob
         cPacuVepTRwKFY9XaB+ClzfIEY9AeyFtrPHbNrmwXvhIMxEFi52HYnP8YBlbar4kqQwq
         ybz+OifnnpUlq/Bo7gzgKChrFje68+JaTQkcjlAaoaIlTQB64dnXFIu/tPkpuisluMKt
         pt4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ynZ2XBdbslE1WoArPNQQVVLJB+hS3g1ZlbeqlJR3SQc=;
        fh=T9UedjoFqrsdB4iQbmT9U0xC1KjfsZMjod9AjKuVoOw=;
        b=ie2bZD60P5cjiZ9KTyTvQt9gvI3943/+nN6RQMAwv7G+2J1BxtcnYCwQ4GtQjL84ga
         1x1rcKbuvlR8HuUmclRhoN6UXXhAVfxS7sh5AB5s9mexj+yAwl2nBcixijZqn3h6vqVV
         oIXeOipGUhPluJNp8YIyK/JB/ibUYzfQZ1VvuGQots9TCUWRmJS1XyQQWRuLqP/kUQC7
         qrEPFRrwhrlcOUgymaNE3eNVCkt1rKUT3w3TUXF1kKP5D6t8ppvlkUUFu5zylMmfXYZc
         4tX61qRaNz20vp/02MTqRWn2Htm82+PFKMTi3Ds0p/kZB6JwyiNKFSv9acGq21C38MzR
         b+Yg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780075213; x=1780680013; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ynZ2XBdbslE1WoArPNQQVVLJB+hS3g1ZlbeqlJR3SQc=;
        b=SBDtTRoNR33uAR+wbIZ0JCv0frwxfEwZmU2rFEAlhsYbUa14kb/04eYFUA9UH/hfn9
         M7JOO/rCnlPzb8UqrOkFnI3QheC5KrKYOkojjRDgdYd8hSmqIIHwEtZVxjjxyC9RVmNM
         YARsN6HJzUAh1KrtlCPM/L1FqX+KZ1HZIJsJp2LmauS7GShQJghH9l10WLILd0IZWFOK
         qan0G6hXcY5XbxpcGCZWMuL23UxJQRMLo8bTNsStKHWsE0KHq6kFUkU6TYjemR+C6758
         k+Pj4yq7CuRtiHaXJ+Oru1G+EMlPFN3v+ZpLIt4oT3HEMvuUU+fxysXD5Zgbze3aJJs3
         nnuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780075213; x=1780680013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ynZ2XBdbslE1WoArPNQQVVLJB+hS3g1ZlbeqlJR3SQc=;
        b=T4zzPqerBv4OP8cBvOMrBXNLOl+MDWqdXICGWq3gQ9qMy9txxd+YK71KaHHNBmdowd
         WD9dUnhJNSHZtel9hIZQ6sGtXfpWR//+5XXbDHAn16bA/kN8QoapAKX+ghevcHCZxiui
         Wh9hVSCffjZim7uYssG6d8Dpb4Pco6TMCwJgREJpIKFKOQojhEqXoz0yYOOlxX50q7LO
         KaT/KyNVWHXBTLUq1JW5Aq+w5iU67Eg2YhL5zqD/2WJh2YkRayB+RH3562Euo4TQF/Ga
         Dzi4lL+u/1AAJK5UTnTsdHzs6N89DPTsthLjwWjPjQpKT4hhBA4N7E4DicNuGeO+Bu0y
         hgFQ==
X-Forwarded-Encrypted: i=1; AFNElJ9o0LDbYEQyl5WD71Rn9dlNX7IxFPqQfsRjSA8l94tS7e8jPa+oBR+u3IzpfPhALzcnM8hhUTQaXXBK2vJhrg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzgOgQOdtz6PfSZCclZlvg0E7wGq/AXE2C9gZjYNvo/W5gKLLo5
	+VJDdfGng3end9MGhUXCf2ZJQridBimmKDGfLHuMIa3bxjWqmnfzMsE+X85QnHKger7n0MpgvMm
	GdsT0ti9xcDPTaCh6IAGM3tWbND2i1Ww=
X-Gm-Gg: Acq92OE4YlLfzYMw9VJPyGhxq68pkjCvAQqcXJjJpw/wNMmWC4KnGCrn7/9omA4TZA5
	xVfzMw8CoIJnrYTTCMff3R0zAbhsiIuDrlgx2EzVYn0BMxPdOz1yXUGTaVTQZY3uZv+WBwq27Z1
	oG+oXBu7etvNflkDykV6dby4Vai1qM2ECY/KNCYmB/guAo0I3c1u/W55TIbCdWCt+l39U8OTzaw
	8EsQXCTWU6/5X4U6v+vQ1gBcw0lDjGj0eho5Sg7w07DMMb4Ll4BGwrxgGw9tzn9trhE/mE3H/NT
	vuboH18icwTZlFcEJoQPYHyGXide+hssv1B/y4pItVD3YBocZw==
X-Received: by 2002:a17:907:9282:b0:bd4:6da5:d5b2 with SMTP id
 a640c23a62f3a-beab0dd8aecmr26412166b.1.1780075213265; Fri, 29 May 2026
 10:20:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260520225245.2962-1-spasswolf@web.de> <fnrz73n5jojl2wlbgrsjdtu5zuwykwbcjzznaijbquuovpoand@i6ihdqn7a6zv>
 <s7cu3dpioidx6mepmai6eyj2pxjs4skbw7v534zbzs6g2fwcis@cvokidcxy3xa>
 <4f548d61b2dd12e01f401ce4b8c865f238f7b23c.camel@web.de> <878q9dvzh0.ffs@tglx>
 <50e5e76bc13256e3f5b3301e92f159957c3d6762.camel@web.de> <CAGudoHGk1CP3gRQLCV85AFHKx6vBEyKySOn4J+AZVAP2FkrN3g@mail.gmail.com>
 <70676dae700e6a40989315bf31ea269a509ddc0f.camel@web.de> <CAGudoHEX=Su_ehV8nNP_6Onfh=hB6uiyTTCojR7nSOkEj6zh4Q@mail.gmail.com>
 <7e8f3a515208583d06c9b5ca18a3e007a8c6b692.camel@web.de>
In-Reply-To: <7e8f3a515208583d06c9b5ca18a3e007a8c6b692.camel@web.de>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Fri, 29 May 2026 19:20:00 +0200
X-Gm-Features: AVHnY4LcAg9EMC0vBy9pozkVNxhEfZnN5xmOlqt1ph5yPNhhQZBBmhxfALKw18o
Message-ID: <CAGudoHFPXP+i3q4HsZqmZaRxw-UjXX_RiUosteVESO2uv-qhew@mail.gmail.com>
Subject: Re: context switch within RCU read-side critical section in
 next-20260518+ with PREEMPT_RT
To: Bert Karwatzki <spasswolf@web.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-next@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, adobriyan@gmail.com, jack@suse.cz, 
	viro@zeniv.linux.org.uk, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Alex Deucher <alexander.deucher@amd.com>, amd-gfx@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 28, 2026 at 7:59=E2=80=AFPM Bert Karwatzki <spasswolf@web.de> w=
rote:
>
> Am Donnerstag, dem 21.05.2026 um 14:01 +0200 schrieb Mateusz Guzik:
> >
> > So overall I think we are done here.
> >
> > Thank you for testing and sorry for the breakage.
>
> Just as a reminder, this has not been fixed in linux-next, yet,
> up to version next-20260528.
>

I sent a v4 of the patchset with some extra touch ups:
https://lore.kernel.org/linux-fsdevel/20260529171840.2576445-1-mjguzik@gmai=
l.com/T/#t
