Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F56319851
	for <linux-rt-devel@lists.linux.dev>; Sat,  8 Aug 2026 01:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786153269; cv=pass; b=pPvYMD7yL9wsl1SMotLmAXS7yd3cp8Ne24be+dolQUiLGp26Tw1CzjhrLx55j6xFoq4/DQmiFjxZCLTyWP2ZjjHIv6x/StuGHWZ3z6qoGSvJJEBZ4jb1cVPy6zeGCLN4K2dYvtHjodND5YiVOAF6UvGiaON17n6etyNUaaRnnQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786153269; c=relaxed/simple;
	bh=J6v6peq2pcAz4ZTnsFALAfBpXXwe0QNWMxVmWduDSlU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l559rDE+ZxToXMPaRe9eeS2s0QY4rkLopIJDpcgLq7LdAr/WVqTDM0EbwjhsHfRCcJ9/NE0RkwuPVmcsN8CizqHW8jTYJJMIpubqO3ffCTQJZyqAJ3VBY2fUkTyn10uxByPYiRxdenkrXVG+o455tr3sL/9MgZM9MPw5RyMwa44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=umYabTPJ; arc=pass smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="umYabTPJ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ccf2360620so1394785ad.3
        for <linux-rt-devel@lists.linux.dev>; Fri, 07 Aug 2026 18:41:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786153268; cv=none;
        d=google.com; s=arc-20260327;
        b=PGZwuOSuSWw15cprfaTfXB1V2VVfcZ302Izm/PjeIqi0X0SL7mYEz0Wm6AUaPFqupz
         qZmRObdQ2e1JTq0/SHbDT+WbEpiiaZA2mmwwEHfnpYvg9MXiLwRPtTVjz27BF4B5HRbl
         51tDaawDEJPA+4UrL1wmqPxjYZLEJxyzmsRZ3QSGS5hMp+hV6XLLl0KxHA1Tpgy2Ypz0
         rMFAOHPTNKa3oer+2RUIKCQRDMfoaR4u+XTU1vjaKNZSkzPh6V1W4/XiikKfMEdCwHg/
         3MRERwZKDqdRPanwgvPj+f6AISlFYE8Ny7YbxNkv3sXtYo9mzRMwk3AozK8XMkiZc9Ep
         Mdgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=K33TW3QT82O6/MHuB/paGse9ECFvxfuZooBXxXgxnaI=;
        fh=QVU8aN3cQWkWxX+LW60/CpXG9MSgpWd5/rzqCwHqXFE=;
        b=QXBPY25S1v07oh8YpiKN3x0eBoM5vG0Z2TvY55FxNHc+JPTYU8AxL9iFr2Xxdhx4OA
         uCRhO+Ff6F6yN/Lg+sIDSRyZuKhRgXoAUivY4CB+pgAFPlJvEXoJvjqjiCE5Iki8WhUZ
         swZ6AsKroqIarrFPBSgDFsOlde2CLoxnQjrVkLeTxFMUVQv6vFwI3SmEhwI2G8f/WoF8
         s1WCODF7Hjvb+JwMagHNrbn3cHSyntllbt9brEE1p9kGTSCJGdPgmyEjf/buHtzrRm94
         01+yqzcQUrrZr7xQpBxBlx1RKkzIU6M2V8iGacFdQZtTOpHNZ4j62PfyFvCYA+HHatUa
         HiYw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786153268; x=1786758068; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K33TW3QT82O6/MHuB/paGse9ECFvxfuZooBXxXgxnaI=;
        b=umYabTPJh8G4P++qHBFrwAnCJ0YWW3N5ADJ7DBYjkFS/T3ok4IBy+wY3dRu7QDfwF7
         MKIK+Rk9ILK7sAJqa8AE4xSbIP9s40XqiXM2WjkIMNHrd+uBhHslfDgR26KoTid6rTB5
         iNfzlud+d17GNDwr6A9IbnMVS8A+e5TsR96I8hFbEyhikvJtnoXTVXb6wddC5RzKH2ST
         S0H9qzAD37eS0ZrDnb24NBs4SSmus+U5+hNNn1L0EN2RD7x5MSfVU9Emg+1gM2P2TBkp
         ycNtNawuywlSmL20UyPCRV1Dt5+lR26FGLAfuA5mfQxtBXiw8yht9o8erOolVj0HnL2W
         iiyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786153268; x=1786758068;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K33TW3QT82O6/MHuB/paGse9ECFvxfuZooBXxXgxnaI=;
        b=OPG8j+SFxMVvuI+L3C87OLNILwzXRMZty/uWoXnEWzijjxviHtWhn2GygexGM/i+Lq
         yu03yP580MTPMFC5oz1gP5Gmxw4vdCcLoh0Lnty4scqnN8z4USIVQj3XrD8T5yrHoJcb
         8aveneHetCvCRxAoS+DI3ngrb89S9MQnUI2cSY1Sqip4eJ98kP70hOJ3zpxJhhU77LHi
         uXqZTX71HT/QOc+XxGk7+C7JZ5PkmSUVI3IFqdfTgkqnvOTwASDd3Z+lvNA+B/IchXwx
         G6XeqWklMzSt90j48dWHa5rzHCqkleZPSFg9ZnPyLRIYHHkktMFudyVffA4p+OlDQY+M
         bIEA==
X-Forwarded-Encrypted: i=1; AHgh+RqSeETtAC1sOzTs9v9nCo5Mjr3YneAuTEEr1quCoGcjjDwTXOiSPBkSMsTiIAgExYEN8eBqDpi/k/31Zs17vw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwIXBRHuw0uJm9v9nhmhrbZ9b06FKNJseBef0Fc2JwlsLb+Br8/
	+ALQFLqJSB/RocGXUsJFZOpHxQxG3nGnLRgzSKTZl0nAInap0W9ofXizsdXna3eDDT67RtpmlVO
	u8BA+Oxqsd1HhsRx/xcSERKREZOQCokjh8Qh/JOq7dWyy3WDFRd7PLeAbLu4=
X-Gm-Gg: AR+sD11EgYkmePtfy5aOWfvv7oTwdEo4CDw42JGgqxj56Fm3EaiCd1tIl0BBbTL3jcQ
	wbJ8v9xjXxwAdmm+3+aeiYnnLG8gjsFBNu3KmUX+TUwVrlyzD/zOKToLhPmqJ1OvpI9gYFi2K8L
	ccamVhBTYqaeSAzNy3q7Unl4CFWXBYlXVQ7WwtmC4l1u/xkWUFR1w1eneV0adAH/aALuK4IFsFP
	YXRuRqWIAkZfdB/6HoumAfO+qJulT0u+Nba5rZ3Bzze0bwxr820BG3Sgq3wj9np5isb4d3MxRmI
	g/EvCW3ql3AGqVwNsoE3cq+Gqj4UpSPvy7eYhzQMJhyM6QKawxONqrgqAwOIrwZLjvRZ+9VGDk3
	TgJ8/Y26Siid2X4pS/MvNhvRtyiJWc0fryT54mJ3nJsEe+jqxnh4vc8R1TKNcPk1NGfcfpY5iGK
	zba7jml5tZ3IUrrA==
X-Received: by 2002:a17:90b:5343:b0:37f:a915:1c29 with SMTP id
 98e67ed59e1d1-3909d9174b2mr12356788a91.19.1786153267129; Fri, 07 Aug 2026
 18:41:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <cover.1785824313.git.namcao@linutronix.de> <bc759ceba26d6e20fab3bcf7333ee7e6246696b6.1785824313.git.namcao@linutronix.de>
 <20260807180709.6fb7f2b2@kernel.org>
In-Reply-To: <20260807180709.6fb7f2b2@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Fri, 7 Aug 2026 18:40:55 -0700
X-Gm-Features: AUfX_mwkQ2n41h6YY5wbT9_yjGRlbcWzEI_ZrbQgH0BeSD9IvCNWMhOBG_HaYpA
Message-ID: <CAAVpQUC5mY9gZH=LmRvdZb1F+QbxGPuNBgSXvHh6pTzZO5QSNQ@mail.gmail.com>
Subject: Re: [PATCH net-next v4 1/1] af_unix: Do not wait for garbage
 collector in sendmsg()
To: Jakub Kicinski <kuba@kernel.org>
Cc: Nam Cao <namcao@linutronix.de>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 6:07=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wro=
te:
>
> On Tue,  4 Aug 2026 08:46:16 +0200 Nam Cao wrote:
> > AF_UNIX sockets' sendmsg() schedules and blocks on the garbage collecto=
r if
> > user has too many inflight unix sockets and there is cyclic reference i=
n
> > the system. This causes real-time issues, as cyclic reference can be
> > created by any task in the system, and high priority tasks who do need =
to
> > send lots of AF_UNIX sockets get blocked by the garbage collector which
> > runs as workqueue, causing a priority inversion scenario.
>
> Hi Kuniyuki! Any thoughts?

flush_work() makes an insane process slow down by itself and
the sane users (whose peers receive fd in timely manner) can
likely acquire the gc lock before insane users.

The commit message assumes the GC is low priority, and it will
be easier to trigger OOM and soft lockup without the penalty.

If priority inversion on RT kernel is the only problem here, there will
be more flush_work() instances triggered from userspace, and the real
problem is that flush_work() does not implement priority inheritance
like mutex.
