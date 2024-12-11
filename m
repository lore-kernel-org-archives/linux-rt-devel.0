Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEBC1C548E
	for <linux-rt-devel@lists.linux.dev>; Wed, 11 Dec 2024 13:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733922258; cv=none; b=EXYEM6OGM+f2x1A+/oQrDFzqWoc8bhBD/9Edarekl6bDlc9dzOBy5XzvgCpkIU/V1bERNyqQzZUJ+SUSpetDWk5O4HfGheMnvyo+DNCHNEF0mpd3mZpi0gzonNhUaw9+pr2c+fBc2lxj4q9juvLeN/nqaRWA5lcAku4/ubIbl8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733922258; c=relaxed/simple;
	bh=74wusGcBfuJxxiu3HaMI2SAkHBbLte2qbusEcT7vvRw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Jhf9cSzf/11RVg28FmSmLTkb7WOOM4JC91r3L5zsfNoXAnGB3ddksr+FpuyJ4F086qQ8a8Mmm/lF76upglF82P3aT/mYlU/Cni4fzbwGGep/LanAbvpH5a9f2Wfe0SUUlX96sYP6/FXaOV+WdCoaV9bNtpraMgGq4Y5ZbxVU404=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mDVRsuov; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mDVRsuov"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-53e399e3310so4652023e87.1
        for <linux-rt-devel@lists.linux.dev>; Wed, 11 Dec 2024 05:04:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733922255; x=1734527055; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=74wusGcBfuJxxiu3HaMI2SAkHBbLte2qbusEcT7vvRw=;
        b=mDVRsuovSoINk2oygzStVm9H+oifmbbpb52V9QUukR+438pzcz7J8KS6BczNeAvnid
         VhFJDZsGN2kzwU3NG+9Jv1bB8zOuSlTgG+7ummh7ubvg+0oj629ubKxz1cWQv8SPs6OO
         9aAoKqV4G/ezdsnW+y6fJ5EU8XZ8kNidKNG7bqiYKQoxho4eQsg1IvkYCE9YnChLfgBV
         uK0wn9Xd1HdQg0Oh2QHnJGgIXkraMggwhYX4yVOKEmZrCX8xpRPPBvYXq7dQ84bpuNY/
         Tn6IGKiSZlQ5vkTLURVSVbGaYXEAcRwZ0BRcDtaUPWGXNvmxVrxsC4PPWEn2q27gYgxU
         YmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733922255; x=1734527055;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=74wusGcBfuJxxiu3HaMI2SAkHBbLte2qbusEcT7vvRw=;
        b=ROU72jzaEuL2hUJhjbxYRdpyqNWozv/mWG3aMwGFoiy4xl+D8Bkf6JXC8O19wTUZYj
         V3tpM0uL7gGtwyndGkZovBxWHJXuSLDYlt8GI4Qr04m+0ovR9yF9qILJW88rdN/bjyUw
         E8goP82W8AKj1aYVlJiWm/k8ZdOC6Kj3AMhQZhTKr3x2tgy2dLH0vKyeO5YkeHz53LWE
         4BBUnjwxH2PbtetIrkDx6w+4/FnrOPV8knmR9P8HzB90fM+UltHPAh6NBZv93yza2/ON
         iuTai5zdFnxnI5OeYPNiTP9aOyFLLMm1CsZ8cA9VdxvvSRTmramiGbZn78FM5t8ZBoJv
         3h/A==
X-Forwarded-Encrypted: i=1; AJvYcCUNxkuUITcxKLWk5xuzRXU43H+LKxZyJhYTVnJF9n/5gQLbeEbRWfwKqn+BSXEZmdoER+Cz/M8iOI/1bDwZig==@lists.linux.dev
X-Gm-Message-State: AOJu0YyCaNoLoZKVSpaudp2tsJLU1S5PR2CieXCx+kyBWGP8fOKNHVo9
	zoMD2LRp9P/3QKDCMPqAfehfhsET7Q8fR+M8f9DNLP5P8+4e4v9voixWTxLRZiwc/GaL1CneS+X
	1x8n4T/rgkQUHSr7xBiXHGLbCPQ0OS5UOrCxu3g==
X-Gm-Gg: ASbGnct4z6MoRqsLLJhyv/3XvkiwynMG562Jzlv6zG+ddpT+1dSsMUMdcQcNDUbwAJh
	k3EvmFCqwgImZh/sL5LlotpsX22zqMmyUUw==
X-Google-Smtp-Source: AGHT+IGB6//Aa/9qdBUs97OqLI01wh9FfTforqMFQJWtL6U0HM26bdGgt3fd2jPfYC1+ZrQOgriT60mCRL7KIvudlxQ=
X-Received: by 2002:a05:6512:3e01:b0:540:26f2:3e18 with SMTP id
 2adb3069b0e04-5402a60c377mr883807e87.49.1733922255058; Wed, 11 Dec 2024
 05:04:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241210160556.2341497-1-arnd@kernel.org> <20241210160556.2341497-2-arnd@kernel.org>
In-Reply-To: <20241210160556.2341497-2-arnd@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 11 Dec 2024 14:04:03 +0100
Message-ID: <CACRpkdYP6yWHuWGwHZCe7SQLg-BFtLb-KKHxqrXbeM2hhrsgfA@mail.gmail.com>
Subject: Re: [PATCH 1/4] ARM: Disable jump-label on PREEMPT_RT
To: Arnd Bergmann <arnd@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	Arnd Bergmann <arnd@arndb.de>, linux-mm@kvack.org, linux-rt-devel@lists.linux.dev, 
	Ard Biesheuvel <ardb@kernel.org>, Clark Williams <clrkwllms@kernel.org>, Jason Baron <jbaron@akamai.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Matthew Wilcox <willy@infradead.org>, Peter Zijlstra <peterz@infradead.org>, 
	Russell King <linux@armlinux.org.uk>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
	Steven Rostedt <rostedt@goodmis.org>, Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 10, 2024 at 5:06=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:

> From: Thomas Gleixner <tglx@linutronix.de>
>
> jump-labels are used to efficiently switch between two possible code
> paths. To achieve this, stop_machine() is used to keep the CPU in a
> known state while the opcode is modified. The usage of stop_machine()
> here leads to large latency spikes which can be observed on PREEMPT_RT.
>
> Jump labels may change the target during runtime and are not restricted
> to debug or "configuration/ setup" part of a PREEMPT_RT system where
> high latencies could be defined as acceptable.
>
> On 64-bit Arm, it is possible to use jump labels without the
> stop_machine() call, which architecturally provides a way to atomically
> change one 32-bit instruction word while keeping maintaining consistency,
> but this is not generally the case on 32-bit, in particular in thumb2
> mode.
>
> Disable jump-label support on a PREEMPT_RT system when SMP is enabled.
>
> [bigeasy: Patch description.]
> [arnd: add !SMP case, extend changelog]
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Link: https://lkml.kernel.org/r/20220613182447.112191-2-bigeasy@linutroni=
x.de
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Makes sense.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
