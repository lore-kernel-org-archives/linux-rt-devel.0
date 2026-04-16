Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F5D38AC62
	for <linux-rt-devel@lists.linux.dev>; Thu, 16 Apr 2026 08:11:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776327088; cv=pass; b=N+A1KhBfU6C0qKXU1SfX5Ev1cXb+8RaMGPaiE1mDNWUs93eYNcz4yXQuOI9U6Z7brnKChvNyZn/RiGHTloNh5C6tfz1nhtHItnbYLWmaRuVjopUklRWlUXiI/qQqHt5Qy+hWfeEnju8esZ0shzGCEhBx7AX9kxqdJN59SFtNuL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776327088; c=relaxed/simple;
	bh=dGB65gvZOZsPvqyMotEaPWbKX5wP30gWES9qBlnXrGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ply9/Dqg86QVQEtbyIGD5/g3+RRfVcvsCAivT1eTJ2P5uiICb8DyzJnhwgYApPdrHZUo2SUQVON+Uk+c2Qf2mvLww4awjECTkx6s51szdQYgz5ROSfKwrd/8GGvqR+KGD0j0qlcdxURN4fWWcA+EnluHKvBL5dBeUqQ32BFxwpE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=diVk+krU; arc=pass smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="diVk+krU"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c76b9efc299so2959169a12.0
        for <linux-rt-devel@lists.linux.dev>; Thu, 16 Apr 2026 01:11:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776327087; cv=none;
        d=google.com; s=arc-20240605;
        b=C+iVJXyF//rxgXlasx+J3HZ0CtQsvcBzPrQl1sSPI/1IDpkqLZAyKK2f11mf5pzHno
         ND9XWHLMLVJM3D4W0VZhjyednmL6e128o1DwM1LPE2xjrPiJGsRGLiq8Q5nzVJNxtDC5
         miFLsJKeT2/GbuKVWrXRKu2HtEuhhbvgdybyxSH52c3OUNtLGxipfG3cPMCysJLsXpbD
         USH3Bxu5me//OvtaBIfk4KZdHxgRVjgVscx2t0A9K5Dd4tbL6uvtse/63+8w47xWbnef
         N6yq7OStDgcymiLPQwiO+nv3fTLB6BXJZyPTE0IrOV7BET0808jplweRlBPB5lNHfbDH
         i9JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dGB65gvZOZsPvqyMotEaPWbKX5wP30gWES9qBlnXrGw=;
        fh=o6oVsOE7QEKCOem4ZfEK8LIs4QL81cd5157BX/A8LnA=;
        b=I/WhCadzbCjqoaaQa6sqSq8GNHTqGxmK04IDxCjhGTPSTZxKpHmztj1W15X4LhbsFM
         jrfKuefVbtESyUmDSQvZH2B0JRzves/1nIjerHscVSENwFIm6sMQme5Bez7yc8buz9bd
         hghabCAmSg18EXUoi26dZI6qnZd1/ccVcVrDk5M67o2MVohkSI+Mss0R1l6rGhnXDW3K
         DHkVhhNNcsPx3Bsa/2B5hWzb8+EhngdkdPM6zjqac6biCnnj/XRAvDDiF3CyZXHbkrx1
         Reqpi/Sh/PLOiysykXcxIMkQ12GJ+wSLfJn9PQlH05YFLxuKlUpdMS16l5G7wHoLddfH
         xGKw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776327087; x=1776931887; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dGB65gvZOZsPvqyMotEaPWbKX5wP30gWES9qBlnXrGw=;
        b=diVk+krUhVZqdnBQ3DKyixgV7s4riV5vunAiHZOKx3moKqGDspQLLkw5aEYYdY262S
         K3GSyhFPgNvt+zrZ8Y/xeJrpmNoho9JHbUUIqrssjXAjFwQqHSC+50Rj1Rk6VlEp4Uj1
         1qPnXNk2ZKDH8X9Smikc6asK6JJXZBI3R7K9VYE/EhBWpu70/bre0uC/wNFxCVzMt+Sh
         +gl3mbIzK4RYwnPYViufd0TVmOizU1XCfP2l52Njyqj5lW5ZXw+Fxtik94plIn22rUj7
         KDoIozge1rvuEcZE15db9HNQwQy2clM4mQdKomY7ScEgRRWdGJWsWmAhhIQfZhqxLu3L
         Gx/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776327087; x=1776931887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dGB65gvZOZsPvqyMotEaPWbKX5wP30gWES9qBlnXrGw=;
        b=GPRRaRStmrJBL8m6te2HQLMUijfo/o+YbfULmDW2kyC11ZzlbDgdzsuYyGrIVk1/mm
         pPBVHvm2hTOyceDpQqUj8rZCmBZaLx9Q0kYcgSvty+/znh0ca/JKhhhwfSRRPxxAYP0a
         IZL5pmHHA4r7YHQMelviOydY7nzHntXwpsQAmcrOtVelfmqcQiGoRMak5mzvVkfJygsu
         5JLOu9HwzMDZ9jSYrhg6JUGEd0IbffCEl7v2I9zMJ4Yxy2IAiFuHkIbQ0bM8EDnxBaLS
         ZG88xgtTjihYb0LDOCcLroc0G/XrWstJtdbmx3Q60dd+WpQGZzlIM7KWoW9kyxZgWESH
         fG9Q==
X-Forwarded-Encrypted: i=1; AFNElJ+FLjgalulVNOyIm8Vhgxyf2wy6z0sNhsyACBcZSEU3w7loMToMqyN51+YBJnXTjB4kzdoiMGT28saxE5WZHg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz5hkiowj8N9gCRZoYWhrm+H3n1HqnVt4ouW/YQvH4NlM2geTxX
	Aw5y+j19Ao+WoEMaPpKw6+IIuDwT3YZJySG5fxUDJeLGxustB5Ffu0+UuKrs6AwXbiBas9JCUaD
	s5VhFmGrklQ4bJ9SoR5h9ZEYYiYQ0XLY=
X-Gm-Gg: AeBDiesiPHJtQ2m8kPsodkVQXCts6Va61YyfW8KoZY5qsb1BMQVTxq01z64QKfnRXT5
	fnCTyLmZMbd2xmKKfFdHGqJZF5XhyDWTzcgTHzTBoQpkunEeko/xhkpkpeI4GK7V98dS2N2MD/q
	2i5rgW3gwjJaMMCe4+M//Wy1WwgiM8StaK+l8OHmGOTtsqvs1VO1+jyn3e20UM4fm6iCNnE6Vdv
	ehERU6nA8j1oTUeyjlIWFVdsADl94bvj0Uow3AdsPzG+AvsFvuM7JioyNOM4UZ02JQi5KSzXSzN
	gE+Uv8ei3Ynh5xp8l8ROAqm441JBa6STqeqCjX+Z2EUn5pca2A==
X-Received: by 2002:a17:902:f650:b0:2b2:4e70:6339 with SMTP id
 d9443c01a7336-2b2d5a58218mr260855625ad.25.1776327086856; Thu, 16 Apr 2026
 01:11:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260414125933.3520885-1-fredrik.b.bratberg@gmail.com> <ad539mUd8A0lDWAw@slm.duckdns.org>
In-Reply-To: <ad539mUd8A0lDWAw@slm.duckdns.org>
From: Fredrik Bratberg <fredrik.b.bratberg@gmail.com>
Date: Thu, 16 Apr 2026 10:11:16 +0200
X-Gm-Features: AQROBzCB1qfVdT-qV8WsW7BK4MvCAfOLYKrAzfLkUcyBBvGeNLz8wwHvxNaMnqg
Message-ID: <CALP2E1xwgfNmW+u=oyQ6bVW0ZeuQRZK65gR5RXyQyzy1n6U_8Q@mail.gmail.com>
Subject: Re: [RFC PATCH] sched: add CONFIG_SCHED_EXT_RT_EXPERIMENTAL to move
 SCHED_EXT above SCHED_RR/SCHED_FIFO
To: Tejun Heo <tj@kernel.org>
Cc: Henrik Austad <henrik@austad.us>, Peter Ziljstra <peterz@infradead.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@kernel.org>, linux-rt-devel@lists.linux.dev, 
	sched-ext@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I missed some context in my last email and only sent the patch (first time
submitting a patch, my apologies):

"I am a master's student currently implementing an algorithm called EDF-VD
in sched_ext, and have addressed the issue of sched_ext=E2=80=99s low sched=
uling
class priority as proposed in this patch. This change could be useful for
others who wish to improve sched_ext's real-time capabilities. It is a WIP,
and likely does not address all considerations needed to boost SCHED_EXT in
the scheduling class hierarchy. Therefore, any comments on the approach
taken for this patch are greatly appreciated."

On Tue, Apr 14, 2026 at 7:23=E2=80=AFPM Tejun Heo <tj@kernel.org> wrote:
> Isn't that mostly solvable by just not putting tasks in DL/RT and enablin=
g
> switching_all?

Yes, it is mostly solvable. But there can always be some RT tasks in the ke=
rnel
you do not have control over.

> The problem is that RT being above EXT is required for safety as EXT depe=
nds
> on RT superceding it for enable/disable path forward progress guarantee. =
If
> you put EXT on top of RT, it's relatively easy to stall out the whole sys=
tem
> without any way to recover it.

I understand that this patch undermines the safety aspects taken into
the design of
sched_ext: For example safely returning to the EEVDF scheduler if
tasks are starved.
However, this is a tradeoff which is fine for what I am trying to do,
and the Kconfig is
meant as an "expert" option.

My goal here is to look into the possibility of creating custom
real-time policies using
sched_ext, where SCHED_EXT tasks could gain priority over all other tasks. =
I am
aware that this pushes the boundaries of what sched_ext is meant to
do, but want to
start a discussion on whether this could in general be a future
feature of sched_ext
or not.
