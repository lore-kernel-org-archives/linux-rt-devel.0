Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0CF72600
	for <linux-rt-devel@lists.linux.dev>; Mon, 26 May 2025 01:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748223163; cv=none; b=W8oDxlba8pycsXO3ggP+sTnK1qMPAqbqaiTzBvku6X+spfmqoQ90Q1INGn2yp9KjMffIc6Mv/EHSh0oGcNAmmFl6CKF/8MVOwxDQr7wIb7A8rAZc2fEJG1hG5bLnkSVm1z4/a3IXq72qhLnC08b62NPe0+R5GsBLqZJJJgLzQbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748223163; c=relaxed/simple;
	bh=DPzxGL+30NArKwSIOTj/H4E/kNjfJ6ShBCpRyVxyDJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XAwUDm5GC7VtGC5BeCs96WlKrv9AykuY3WXSXLR7cqkW89d5ju5ECO4xc0+p0i+aJgN7VbH2ZbNb4Aj4EIevy8bn8ZXXgFJsZujcS2haMZaHmbnwGWgk2A/NJvTWbqmx18N7WoBrstZLOT7F9Ac4tLPLIxe35FXx9Y1avzOzqic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BXCVO64C; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BXCVO64C"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-442ec3ce724so14443585e9.0
        for <linux-rt-devel@lists.linux.dev>; Sun, 25 May 2025 18:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748223160; x=1748827960; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7cGOAkilx+ZhrVPvSVqSnNR8OUi5MMrk7Cz9BvTY4qg=;
        b=BXCVO64CVYxQ9Q7kgQY3GwDdYrsV9J14HrrrG6gGdGbtDsMz/wZLdX2IuD/d0ZpmlG
         08DisY7bMoVHDiJuX+TUmcIu7lIs0a7hsuqGjsee1y9rGh9BZrLVae8ud26edf3mN8UN
         UUjDIvc4ExH7I9fUA9xxp+AmeSsPwrwVQsW2Hsa5QP7W/ev+35ryC5jxXjWAMw69gcBR
         jJKBzMMFhrJsLxLNAaAfHurBRAEY0ujt++H2RkTNL6XoRqKhHu26gG6Sd0L4eswM7Acc
         bkYPOuSDO9TMhhn1oXrTjM53YzbJDmPFzzW1hUecel4j+ua/z8NJXszSQ71raeMGiWgY
         sEHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748223160; x=1748827960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7cGOAkilx+ZhrVPvSVqSnNR8OUi5MMrk7Cz9BvTY4qg=;
        b=QNk1XNZ39LtJMx/Vajh38aDVLIt4otHy119+VAmS8D/IV2HKTQaiQAnJt9AgW5SS7u
         WokZv6OkffPNjLvE09tvV3wdxRGuaUqLVFwPgmgttj0w5ZPb2wowxruLKGbm4VO1veEA
         H8WYit3LRMVUEo91djazu15Cwo4LIkfeDQBcNgk3TAEvy2PdP5xjkt9rX1NXLCntjOXq
         y5rITO85wknVcy0M2NsQlJmYxJQ69fyzMNVPeNanVFfT4qUh60egayU7o7WspEdY0kUW
         2GoS+Gw1gSeKR6UWu3+YeSWGMRmUzbX8jNRKPWqcp/f01wQcB7DT+vWQzZuOGfVCFX94
         Q5+A==
X-Forwarded-Encrypted: i=1; AJvYcCVvf788Qp3oB8vrtAiUeF9xktqLlH3AlfgAdV8o+3bzf2XtZm8qcxaYlCXr8etg4aTDHerX+1os85vGs/kh+g==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy9lacgwOvYRXmHRUU1IEsO85in2QPXXUYKmNCxFQL9gh8O1woA
	EmiCE0ZDUBzm1U3MUQm1+huQ/oKWIRqL5478YmqswEkjbUhZ8sLfKq2vR6b3n+Z4ji9ay+XT8He
	9ad8BJufYMOz1glSw0uxp9Yf0YMCREFk=
X-Gm-Gg: ASbGnct8N9tQ4UaQVbFeCQqSZdDRHxYLmvnzbPSDvRIS6QpSixJ1kNfHfuAAEv3CdVk
	i/lxhYJBuuDMEoqerKCtTIjbVDnj4rjB5cRybJcy3wsUxjKto2eEW2NHGKlHrK5A3RhxPW2NXo9
	Ncud1dY5JBbS0QOJelcK+XnPpNOaEcV7V0woGXoF2LGdwq1gPisXqPJKRVzgly7g==
X-Google-Smtp-Source: AGHT+IE/TAn2rgDxN+u4MYzZJ0OWwlVfL2WOif0YnXD+AwCVO8IKHxTOKFgz5WEb61zo8C8ufdqbNCvLPWBFScAdI60=
X-Received: by 2002:a05:6000:22ca:b0:3a4:dcb0:a5f with SMTP id
 ffacd0b85a97d-3a4dcb00cb0mr71467f8f.16.1748223159473; Sun, 25 May 2025
 18:32:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20250525224744.9640-1-spasswolf@web.de>
In-Reply-To: <20250525224744.9640-1-spasswolf@web.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sun, 25 May 2025 18:32:28 -0700
X-Gm-Features: AX0GCFvm_Bez1rb1JzQSzoshh3hDkoxHtoczG6bLZpZvk_pvgCEczCjEXVFe4WI
Message-ID: <CAADnVQLv3aX0iOrkAZRgP2x8UAVvy7oYA8x0dUPn7B6FD-10-g@mail.gmail.com>
Subject: Re: BUG: scheduling while atomic with PREEMPT_RT=y and bpf selftests
To: Bert Karwatzki <spasswolf@web.de>, Tejun Heo <tj@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux-Next Mailing List <linux-next@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	linux-rt-users <linux-rt-users@vger.kernel.org>, linux-rt-devel@lists.linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 25, 2025 at 3:48=E2=80=AFPM Bert Karwatzki <spasswolf@web.de> w=
rote:
>
> [ T2916]  rtlock_slowlock_locked+0x635/0x1d00
> [ T2916]  ? srso_alias_return_thunk+0x5/0xfbef5
> [ T2916]  ? lock_acquire+0xca/0x300
> [ T2916]  rt_spin_lock+0x99/0x190
> [ T2916]  task_get_cgroup1+0xe8/0x340
> [ T2916]  bpf_task_get_cgroup1+0xe/0x20

Known issue.
Please trim your emails.
