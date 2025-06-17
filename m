Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF63EACD
	for <linux-rt-devel@lists.linux.dev>; Tue, 17 Jun 2025 03:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750132747; cv=none; b=eBMqaceFhM41cAiyQZDsYsavHJntdGOaqIH1mjguEo31+D4Slddv4VpXOJKUKF+iJugqeuMtSOG57nDyWZuQICxgnnwa9j50LyXuLUoeuA5ue4TMjsAwrY/VLHTi8f37vEL/2sBSQukfE02G4SldEg4sCqdhibClwVIXKMIPNuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750132747; c=relaxed/simple;
	bh=x4nt4iNeJfsqzWygLbzAoicdlPD7trp0p/fleKKM5bA=;
	h=MIME-Version:from:Date:Message-ID:Subject:To:Cc:Content-Type; b=E4k67ovxsFCd0h5u+icyMAT3gLdcS37rnXLXw67dcGX7N6SFNotZPi4+udE8Zc72FaaO4ifcXN97sM4nmnhTnISUQgsDRhjAoxEF2LMJEvLRFAqh8ckiYPAvOKSWDxFoPtJYPeDpz7teCqLMcSQVuylHItMvth0FVCH0lx2TDBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org; spf=none smtp.mailfrom=kernelci.org; dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b=UPHFnucm; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernelci.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kernelci.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernelci-org.20230601.gappssmtp.com header.i=@kernelci-org.20230601.gappssmtp.com header.b="UPHFnucm"
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-e8276224c65so267569276.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 16 Jun 2025 20:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernelci-org.20230601.gappssmtp.com; s=20230601; t=1750132744; x=1750737544; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NXr35vqFslJoXbNr4b4N5Ogmu3LfeaagVLe5cSS1Gv4=;
        b=UPHFnucmqyURIR71E4u3c3WOozO7/P6GxxiasAVpt7vFuGcVz163hC+G1UwqAyR54s
         Hu8r+GTsttCrS4pJLj8mfCqud5e7LxWY83FQ5KqUurYazTK3c1Zc7878mmuBShYDs1w8
         yRnyiwlT44KWffeWjs+ru18+VqkkJjzrMTEEVCR6Db/JlKEZtwLvzLviZy9LkSS7gYMW
         Mzrw+eGMLwaDo5Dyl6SnfuOKRwpLQAKdQ6TwIEyJVX+ot7ZiwY/7U/uUK8avveoAszAI
         Vxp95LKCC+xTbiDxV/ZhWllHBK/VbLRQBN5WGO6ScyhQ+7OttIeAfOOZq3dCRWoua5ea
         g0jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750132744; x=1750737544;
        h=content-transfer-encoding:cc:to:subject:message-id:date:reply-to
         :from:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NXr35vqFslJoXbNr4b4N5Ogmu3LfeaagVLe5cSS1Gv4=;
        b=SCuJThxcQ8L5gZ3D3XaE4UnVOBf2/NT/gtKdJr4dCrBTDcCXs/xFAlF6bf9FXbH1Ov
         EmazOVsKKtPQspmOA++WEOjOrr0AozTeq4lR9wcti6hvI7uFdGqpsf+6RG5ENTaLA+GE
         a4V8TASX9VMOju7LPuClFjkqQMir9Hxtwu2awiOv4l4tl+3GcXgx0q3NxLUi6Ptiqo2L
         WJ3XiMPYLBAWfqE8e3LJ+kxb1k1kB3+mEMn6nQPrAAbFS5OjEOPzf5rORrdkRqTaQJJv
         ws54OrHMnANoqWgmtjBbPtRPyEyCGuVYpYjZaVVuRVIXb1VQbNkYfRmZY42SC5xgbpnL
         LZrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUR3mKmEtOHZBiyD0DlnCVoowxJY82ky9JAaR9zW0Ih0UF3QuEbuApzCHHj5pgKYW5G/mBp/rz+p9AoeqtQjg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8R6Ss8nEdVKAkTSlfsgZk/xH67tqi7MGUTfR90otvtlafb2vI
	zB1SyzdZX7b0wqeLgMDgf9fefaSy0QypT10yDjitNrx7yQeh+qACPrRMi062Sq+hblXKy45MWXT
	OaQGqvWZuw3K3tf39iwZ79AKVL1lXkqoivMphVd/YnQ==
X-Gm-Gg: ASbGnctKWdC42JaIjkxeHjvBrK9tCxIk0MdxHnrgEfpX3heaPMiksivqALLT4xDWhC5
	RNVyzcSttMuXPQEYdGVH/zO+eqIJ5Quf1HJio8mlFWGdEeqSDLl+v6Pdz8RU7SAt6CPIXJdKPjX
	a3MS3kRSggpMuaoN249Br2Ri9uhXAnoaRfnQ5lbUsBcQ==
X-Google-Smtp-Source: AGHT+IHcyTOLD1xW2pNcHSa1FM7XeTZVGMJlGkLhNfesW7dvZqjzDEZIkrGWWKvRPiu88lWNtmKEolcV8rb/6njEN88=
X-Received: by 2002:a05:6902:1a47:b0:e81:9fc5:2592 with SMTP id
 3f1490d57ef6-e822ac785ffmr15705830276.29.1750132744331; Mon, 16 Jun 2025
 20:59:04 -0700 (PDT)
Received: from 415818378487 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 16 Jun 2025 23:59:03 -0400
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
from: KernelCI bot <bot@kernelci.org>
Reply-To: kernelci@lists.linux.dev
Date: Mon, 16 Jun 2025 23:59:03 -0400
X-Gm-Features: AX0GCFsWeYSDM7mEIt9kIYbSUfCezDQhH3jIziU_5Bp6iv7BPu8ovW8wjsUr51A
Message-ID: <CACo-S-0_rffhUzvSbHZvQa1OHnxTpQiezNCga4Xnw+bNuBNNvA@mail.gmail.com>
Subject: =?UTF-8?B?W1JFR1JFU1NJT05dIHN0YWJsZS1ydC92Ni42LXJ0OiAoYnVpbGQpIGNvbmZsaWN0aW5nIA==?=
	=?UTF-8?B?dHlwZXMgZm9yIOKAmGNoZWNrX3VuYWxpZ25lZF9hY2Nlc3PigJk7IGhhdmUg4oCYaW50KHZvaWQgKik=?=
	=?UTF-8?B?4oCZLi4u?=
To: kernelci-results@groups.io
Cc: gus@collabora.com, linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

New build issue found on stable-rt/v6.6-rt:

---
 conflicting types for =E2=80=98check_unaligned_access=E2=80=99; have =E2=
=80=98int(void *)=E2=80=99 in
arch/riscv/kernel/cpufeature.o (arch/riscv/kernel/cpufeature.c)
[logspec:kbuild,kbuild.compiler.error]
---

- dashboard: https://d.kernelci.org/i/maestro:09fe4370872596f20cdca497ccf72=
39e25067afa
- giturl: https://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-r=
t.git
- commit HEAD:  5495197730f86d3227ddfc243ff2980747a321ff


Log excerpt:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
arch/riscv/kernel/cpufeature.c:580:12: error: conflicting types for
=E2=80=98check_unaligned_access=E2=80=99; have =E2=80=98int(void *)=E2=80=
=99
  580 | static int check_unaligned_access(void *param)
      |            ^~~~~~~~~~~~~~~~~~~~~~
In file included from ./arch/riscv/include/asm/hwcap.h:73,
                 from ./arch/riscv/include/asm/alternative.h:19,
                 from ./arch/riscv/include/asm/errata_list.h:8,
                 from ./arch/riscv/include/asm/tlbflush.h:12,
                 from ./arch/riscv/include/asm/pgtable.h:117,
                 from ./arch/riscv/include/asm/uaccess.h:12,
                 from ./include/linux/uaccess.h:11,
                 from ./include/linux/sched/task.h:11,
                 from ./include/linux/sched/signal.h:9,
                 from ./include/linux/rcuwait.h:6,
                 from ./include/linux/percpu-rwsem.h:7,
                 from ./include/linux/fs.h:33,
                 from ./include/linux/compat.h:17,
                 from ./arch/riscv/include/asm/elf.h:12,
                 from ./include/linux/elf.h:6,
                 from ./include/linux/module.h:19,
                 from ./include/linux/device/driver.h:21,
                 from ./include/linux/device.h:32,
                 from ./include/linux/acpi.h:14,
                 from arch/riscv/kernel/cpufeature.c:9:
./arch/riscv/include/asm/cpufeature.h:33:6: note: previous declaration
of =E2=80=98check_unaligned_access=E2=80=99 with type =E2=80=98void(int)=E2=
=80=99
   33 | void check_unaligned_access(int cpu);
      |      ^~~~~~~~~~~~~~~~~~~~~~
  CC      crypto/proc.o
  AS      arch/riscv/kernel/entry.o

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D


# Builds where the incident occurred:

## defconfig on (riscv):
- compiler: gcc-12
- dashboard: https://d.kernelci.org/build/maestro:6850dddddba9af5ad63ecee4


#kernelci issue maestro:09fe4370872596f20cdca497ccf7239e25067afa

Reported-by: kernelci.org bot <bot@kernelci.org>

--
This is an experimental report format. Please send feedback in!
Talk to us at kernelci@lists.linux.dev

Made with love by the KernelCI team - https://kernelci.org
