Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A0394C9E07
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 13:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792156804; cv=none; b=uRLZTckeOMwMcXWj1wuUurqkZkmhvErvCJhjQLGC3KJfGCOcCEGLl6ldo8bZ8IK4+Ra0NRPl5Ffj3tIR29febCDqF3i0a2RH4uABi4MkzzPq2RX/BJMWy4R1GfkXFCxTyZsDc7tXDdn0grDOJQRFmnoZXuQLv2E2dofrQ+5N4U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792156804; c=relaxed/simple;
	bh=htcXVBoJ+Oi571ojYkob1zz2/Li5ONJ1UWcvCyCVl6A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IEjMh7mr0wemPAfpBsOy9Yw8hPFxDcB6eJFYwGBtU3y18tOh/HkvkU9e2gyuUSgU5gsx0LtU0vFPj0eLQOfi7qVXqMKfqoCoXyIKSWB5pjvHXCX3hzc5PICOTiOJTsOdKoBqs3lY4ScmyrHBr/rX1iMVtTUOY6eW/rO+nTvfAK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f8X54eF7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f8X54eF7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 765511F000CF
	for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 13:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792156799;
	bh=htcXVBoJ+Oi571ojYkob1zz2/Li5ONJ1UWcvCyCVl6A=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=f8X54eF7RLyztOsQqmnAyN0IQARFaLQzxhmph37vBS3WwyzriRZ2CEx52VxcAvj03
	 LW6FfeSRUceVdXIObmpsfHsqNWAZV4KZc0L+lhkP675/kW3yXd3S2ahDCy/nCyPAkP
	 tRFBlnSHW1JzVhMZtgNHdAiXoTkrU0Gv1xlfxO2rX0A0XswOFN8Ucp4R4c/98xSa3o
	 iQg0S2PtniLobKz7f4Qc40FH37DYGpu+mcUpW2Mxpvdry/a6+/g+KBy2cVlTAs+Rug
	 0ma+7Nfg61VT3Q3p1ieKBGcJszYV+eMwPaAm6KVRdpjBPIsZTJpS0sXyWsogw+Xx6Z
	 QBkhkomp7ayiQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5bb7c6980f1so5243037e87.2
        for <linux-rt-devel@lists.linux.dev>; Fri, 16 Oct 2026 06:19:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwQZkojHR4v9W/GySxAGQro70kR9KIbGKJLhMDQ0O8HK13hlkNjQWoqGQcxzOeHkwEsbXX6apuH3XitPla93A==@lists.linux.dev
X-Gm-Message-State: AFq9FYIOmWyhBQE3ECAjF5PzPS/XDRvkPDH36d9lBZZn9BwjP2NS+hxc
	S8ud4Tzo1NPVG/4B6wRZg8zQZGMN5g/M8wgMiv4tgNhh0ONW3emZxzxxoL4Mek/OqAGck+Ok7mU
	Kv4L5KFE9k1V39hCTf9ddjpbY8dqv+Gg=
X-Received: by 2002:a05:6512:32d5:b0:5be:4792:82b4 with SMTP id
 2adb3069b0e04-5be47928585mr1064494e87.19.1792156798198; Fri, 16 Oct 2026
 06:19:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20261014160917.139241-2-junan76@163.com>
In-Reply-To: <20261014160917.139241-2-junan76@163.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 16 Oct 2026 15:19:44 +0200
X-Gmail-Original-Message-ID: <CAD++jLk9Rga0OuaKyojE2ViT9cBcmD_Ow-pMth-qJbTfHgcybA@mail.gmail.com>
X-Gm-Features: AclHuK_KFf_KBCaZwGWjeEf8eIfhE2fCyZ7XO76MOBzC6uLnM6o0vpqUkSR2sgw
Message-ID: <CAD++jLk9Rga0OuaKyojE2ViT9cBcmD_Ow-pMth-qJbTfHgcybA@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] pinctrl: stm32: fix hwspinlock timeout and EXTI
 mux locking
To: Ju Nan <junan76@163.com>
Cc: antonio.borneo@foss.st.com, bigeasy@linutronix.de, 
	alexandre.torgue@foss.st.com, arnd@arndb.de, clrkwllms@kernel.org, 
	lee@kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com, 
	mcoquelin.stm32@gmail.com, mfd@lists.linux.dev, rostedt@goodmis.org, 
	u.kleine-koenig@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ju,

On Wed, Oct 14, 2026 at 6:10=E2=80=AFPM Ju Nan <junan76@163.com> wrote:

> This series fixes two problems around the hwspinlock-protected EXTI mux
> and pin configuration accesses in the STM32 pinctrl driver.

Patches applied for v7.4.

There are still complaints from Sashiko, but Sashiko always
complains so I'd say at this point we are close to the merge
window so it is better to follow up with separate fixes
if there are more issues.

As maintainer I kind of have to decide whether to wait for
the perfect patch or if perfect is the enemy of good and
just merge the patch so the baseline looks better, so I
decided for the latter here.

Yours,
Linus Walleij
