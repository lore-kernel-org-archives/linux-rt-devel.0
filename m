Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB053C6A43
	for <linux-rt-devel@lists.linux.dev>; Wed,  4 Mar 2026 18:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772648017; cv=pass; b=kOuznlZ7vaf0p8PdhywiOR4EOGFXpsvaSG+17dFQ97sBq6tQ42bRHlXNO1qVdetz4/K+lUqz5VFMHtPqqpFn86tIfKiu3RLTrxL1Tq2uN5RwGFTjw2nYQsXtfs29ty2OOkBIk0gGQmBTe17aDTjnqgNsHe79BtCqxsKEtCEDyPU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772648017; c=relaxed/simple;
	bh=Bz3h524S+Me6wnmPEXTEscST+QbpKO+D9vNqguqzmeA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ScJPLF3WrAsIbyNMP4yTa48o4tzm4op78djN1hBDQttalGSIxcAf4EV+GEQQr3aXckxi9DojOn6ilSwlBHH1Sqbp94clbHYxUhml5rpsLeVhqYls/wb8kPeHmXEzrfroa/zAL19xaTFiPYFxtuF6XNlZ+zZt0gB0ZAyIsMX9aIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=StnyxR+6; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="StnyxR+6"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9382e59c0eso126345466b.0
        for <linux-rt-devel@lists.linux.dev>; Wed, 04 Mar 2026 10:13:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772648015; cv=none;
        d=google.com; s=arc-20240605;
        b=Hj5y8pnCjFqbOXliooXPOCEFgsGDqFU6Q8H4ibLZu0++XydydIdUbBWTylbHu3X6A3
         BbyZryO/irpsxU1z9+gDCbEL0985TJaG/nU5s2CT9vuITneJfY2igzlZAn+9z1OPOkQm
         7C4y6wBU/PcXvCRQMN8z2CmOxCVeuCgJ8tr6fiIcacsBdKtqzh6q2PBZRsSybHkmUXqa
         mwN4JdpliWpGvCOi8quzbaXU0szcnmEl4rhN7sgj9wO8UQqT3+2Xl8TNKBxzcGIqrK+f
         VO8Tnh7ytWmUldn6AWSsUgZ+7UzODHUf/Y5v7vmvg4rcCK9FAxdigAhEHYDW0VcGsgo9
         bFqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LrQZQ4TMSoJ6fNc6gcQ++hehPffTagkw5Fo7Aas+Fhs=;
        fh=gLCwxcttEfdi8aiC4s9QwG/79B/N4HKoBed2jV9HUOY=;
        b=eA4d/HVP8q/9j7LozAgCDlKosrMqxfRr5nKNCGlGTbG7Y2APoQ4pXwRfwTi9bZpJzj
         +cDFPF9q3b9pdPAxt8riQcZJ7TpkT4hpjUGJxanMmLYhWCInlArMPHSi79/wybcvDwPG
         bphP09uIk3l0dfAHdtUmXLFonfrmkPYUXw7PckYi1fTgKO41opVtPf2u3VVAxAzn1fbe
         LFGmM+rpzVKeDNKS3x3SxZtSQTQOcHwe1wFDU50ns4OgzvBDfFhav+5GMp1fB6sdy2fX
         aR9AJPxWie7bfR4xep8IkNP0mfAVh7Ojt687sqd/iu3SBv2Fc9iicxOD23kRZMcUrTcM
         umsQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772648015; x=1773252815; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LrQZQ4TMSoJ6fNc6gcQ++hehPffTagkw5Fo7Aas+Fhs=;
        b=StnyxR+6fpaEmhqywh82MX+zLw4fhkOeRmEqr+BRyQYL3u+2SPzN9vzwuIEp6Unxlh
         YyyQKYHLEEX5JCh1ozGCinQVW9aUvF8hgvnKZuVnq2L0slwMfGqicKwrOrsZJ35nYSw7
         g/ccPenGa79bR6Xsyik8HU1F0y+CM4RBapTg+sbSSnZciedLIv/lMCY5qP43lnqvl3ET
         DV01hK9RFiPUvA0R/t+Wvy+SEmmKfC3F4kMQqRMRKJWNrYG4MtMqCqy7+O8iCx52hJqq
         jG/LqPsmPTbReWjxctgS35+yL3/pkPs9naOvEORk4eMSCvXg9WlhLBaMmOaBFKDK6Y4z
         Y50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772648015; x=1773252815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LrQZQ4TMSoJ6fNc6gcQ++hehPffTagkw5Fo7Aas+Fhs=;
        b=tj73TDssQT7USoAMy8lbwJ4wOM0CjEOrxIeVGvNl6HMVJJan8eiw4Kb7CbuYTHM9i9
         KKTGSfib4zxMKpabsD0sNVrj4mxndsYi+W2B4uAHgo36vAM25b0J3ARfszePDmPMwYIA
         NbfPJaKAoUSta35FtA0v2MAFy/Cy/l8/i0Tkk3BWYFUKICdMZxmC27rlSwqt3MIWzN5A
         8OpwuLKmRa/Vw5Ck341VbUx5pVhxpTNsXsAb/mzZGzRH3J/MMT3RkdLhdPj14+lBzsg/
         S1irCVS+dE9yRntfQkLVGlEKECdVWPGaTY7DEhxvCP+1Jogc7Yqklzb75WWkNF7d94o3
         lmxA==
X-Forwarded-Encrypted: i=1; AJvYcCUC5GS2C7FtVO0FH+54WG+q170SkAgFOixwiPJ/EGKJlfyEuEjcY/lgkozkyqvZ4ns+eyABX6ufO3gF09coXw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzacDCtGjfLP0yiXR8KzTlzQvWz+pSKKmeUSveeeWN+clPiTUt
	lkgK8JVkuw/qMn280XaXtLoYrTBnIgX+y2qXUemS5nagO4qQZr5jhD7LqcyZM/IvWB3sk1qoHIJ
	G7eNWbBz+ZFnqkYQXHZIQO7fTpOLb5zC+rL0mZ08=
X-Gm-Gg: ATEYQzxyokWbrYassi/fdmM7xLbfSS5yLlY9SkKp/G6ummOHpuIhLLEKaRmlBFI+Bfb
	OOh9VCgID5oZ6MVy6nX4H71j83VLx2PLY1RztTRxa6aT8Gw20pbVXuWXapXfBO/2cVnXDNTgtHZ
	NwE2dK1G2ZNjj5nxHXhkMyFXZ/dTZIvkTUXN98RLe95ST+73ZAC267PFWtegzhZV+ak0UW3y+6J
	LDXd6TJneqe26Il8larVyu3A8AxEunMYB0Kc/dLMdCBsX8scktq0Onpd+XXjhG4dANKvDvD5EzI
	vEosL0CSBUfkmfO/oD5B4yrso+sOmIgF/ec2M2KV
X-Received: by 2002:a17:907:72c8:b0:b87:117f:b6f1 with SMTP id
 a640c23a62f3a-b93f115d8cdmr207412766b.2.1772648013979; Wed, 04 Mar 2026
 10:13:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260304082348.959786-1-soolaugust@gmail.com>
In-Reply-To: <20260304082348.959786-1-soolaugust@gmail.com>
From: John Stultz <jstultz@google.com>
Date: Wed, 4 Mar 2026 10:13:21 -0800
X-Gm-Features: AaiRm52kw9DqM8ykaOCzBsACy_sm0tnMc9dCpHWbLmYpaCYNPQsq_lqF-pZLAwI
Message-ID: <CANDhNCpNnBzSM9Vx1vbp0dhCwjeKETNwnQnB8sjzX47+GM+REQ@mail.gmail.com>
Subject: Re: [RFC PATCH] sched/proxy_exec: Extend PE blocked_on chain to rwsem write-side
To: soolaugust@gmail.com
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, 
	juri.lelli@redhat.com, vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, vschneid@redhat.com, 
	will@kernel.org, boqun@kernel.org, longman@redhat.com, shuah@kernel.org, 
	bigeasy@linutronix.de, kprateek.nayak@amd.com, 
	linux-kselftest@vger.kernel.org, linux-rt-devel@lists.linux.dev, 
	zhidao su <suzhidao@xiaomi.com>, Suleiman Souhlal <suleiman@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 4, 2026 at 12:23=E2=80=AFAM <soolaugust@gmail.com> wrote:
>
> From: zhidao su <suzhidao@xiaomi.com>
>
> Proxy Execution currently tracks blocked_on chains only through
> struct mutex. This patch extends the infrastructure to support
> rw_semaphore write-side blocking, allowing PE to eliminate priority
> inversion where a high-priority writer waits for a low-priority
> write lock holder.

I'm confused. I've already mentioned Suleiman has implemented rwsem
support for proxy back in September:
  https://lore.kernel.org/lkml/20250926032931.27663-1-jstultz@google.com/

Which the latest version can be found here (though I do have fixes
pending for v25):
  https://github.com/johnstultz-work/linux-dev/commits/proxy-exec-v24-6.18/


> diff --git a/tools/testing/selftests/sched/proxy_exec_test.c b/tools/test=
ing/selftests/sched/proxy_exec_test.c
> new file mode 100644
> index 00000000000..30fc58b9738
> --- /dev/null
> +++ b/tools/testing/selftests/sched/proxy_exec_test.c
> @@ -0,0 +1,763 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Proxy Execution (PE) selftest
> + *
> + * Tests for the sched_proxy_exec feature. Verifies that the kernel
> + * correctly handles RT priority inheritance through proxy execution.
> + *
> + * TC-1: Basic PE activation =E2=80=94 low-prio holder releases lock for=
 high-prio
> + *        waiter within expected time bound.
> + * TC-2: Three-level blocked_on chain =E2=80=94 PE chains through B->C s=
o that
> + *        A eventually acquires its mutex.
> + * TC-3: PE deactivate path =E2=80=94 SIGSTOP/SIGCONT on holder; high-pr=
io thread
> + *        must still acquire the lock within a generous timeout.
> + */
> +
> +#define _GNU_SOURCE
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <pthread.h>
> +#include <sched.h>
> +#include <errno.h>
> +#include <signal.h>
> +#include <time.h>
> +#include <sys/syscall.h>
> +#include <sys/types.h>
> +
> +static int test_count;
> +
> +/* ------------------------------------------------------------------ */
> +/* Helpers                                                              =
*/
> +/* ------------------------------------------------------------------ */
> +
> +/*
> + * is_proxy_exec_enabled - check whether CONFIG_SCHED_PROXY_EXEC is acti=
ve
> + *
> + * Try to read /proc/sys/kernel/sched_proxy_exec. If the file exists and
> + * contains a non-zero value the feature is considered enabled. Returns =
1
> + * when enabled, 0 otherwise.
> + */
> +static int is_proxy_exec_enabled(void)
> +{
> +       FILE *f;
> +       int val =3D 0;
> +
> +       f =3D fopen("/proc/sys/kernel/sched_proxy_exec", "r");
> +       if (!f)
> +               return 0;

? There is no /proc/sys/kernel/sched_proxy_exec file.

This seems a bit like its AI generated, and wasn't tested. I'd avoid
sending stuff like that out to the list.

thanks
-john
