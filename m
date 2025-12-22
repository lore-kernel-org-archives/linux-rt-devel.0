Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52EAC30FF23
	for <linux-rt-devel@lists.linux.dev>; Mon, 22 Dec 2025 08:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766393472; cv=none; b=jDldWA4HVM4sNAOhPHstxA9cGNCVoFJSLSMahRR4UeiiLcyXhM5A2hiKVMWhkOUgCcSMQMnyijNZ2SfYJJz0vllId3LNluPb7b6FKpiOeGDmmAw7fPbpDNT7QJNleFLePSy2DSOUNuMMT4ZtWn9RDSrd/7ibsztTm9vbuZE4vy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766393472; c=relaxed/simple;
	bh=ruXs5/RFst6fuaU8dBOLXd+Sk9KuNS19f9hQyg/KEWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=isY0/QibhEdmEAi/N81WVkm0/NC6F/J0H7xT/2UMR2D3DKGhyinJXN3PK6i4vfjAmSjQw2lVq1dQ2lXXy8+DnctU/VA+mhNHoEhpGE+X2A3ojqysBSuNf49C5CCG0gBostJOEwoao9PTLuN4MgZybXkOt+ZbTaxlb6fmiOTdYsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NURbgcLX; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NURbgcLX"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ee0ce50b95so43302641cf.0
        for <linux-rt-devel@lists.linux.dev>; Mon, 22 Dec 2025 00:51:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766393470; x=1766998270; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YTcRCL2LSV7oA+h6PPnW7Xs5s3C4m6VV54Y7cZ/iahc=;
        b=NURbgcLXfqSjuHXsa+hhjUtRDrjKNhGLNDUIX/OeVtPzMVV8aOBZCEdBddjb3PwnyV
         ERERYkUvEr017c1c5UirNDXfJxXnKsldwIPwbpeKfxzqQmvoDNuZGkguED3eGVeK5fBv
         nthcj2C6hr+0EYim6VkXVY1GLR5Pm7tp9tTIPuh/cbVCXPwAyEiZAI2wy47tE2UORGFa
         KnYYEVVA4YnXmOvrUg1kq+9WNVxDSrXg3QoCDA+s3LbglvHNqaG0SAhhpJNkUxZeJoQx
         2pEiawZ6qjAnPa7NOIxdQByJHpMSxBCsb1t5a/j1xOyr23lkoKP9pVsAJHaT9F4DlT3E
         T6VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766393470; x=1766998270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YTcRCL2LSV7oA+h6PPnW7Xs5s3C4m6VV54Y7cZ/iahc=;
        b=Sm3ckMWsra0O4bs5yK/sKzi6LIu8loYC3+4WCt+FLas2IK7Smph3NUDtnSagps3VRf
         ArT1YBOVrPDDIbZ6viq/MtoDJTF0nspjAxeD9I21x+Q6dyiYyvfyIHZlKDebQV6VoBxX
         9tjV6rQF16PbvR3QFIevaVqfkbb3/BqETZalYgKe+NPQTbI0r1MXgdpii4qykXiJnSaD
         d+fsYR44+Pf4l9C9QFbKAXl0kXee8p+ub4EE88wxC6aSNSvi5veeLvHo+QZWoaDcfnEE
         sDP0pIV/wH34bySIvvHGXZSXzrxYCL/q2Jhi8OM8i0sACkFUxPzVKGpbU3TaNgwkgWNa
         Bv7g==
X-Forwarded-Encrypted: i=1; AJvYcCUjhJ75uNkiIViANe4ScEChcC9eH6st4Zz3GtATrUBahTDwelYzi9J7hhTEBrGKUhH7RhizNSTkAN07Xtmx9w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yy/ll4mzxrXSTvxWX61UAXHJ59qX0XxhJ0V52ft0j81KzuwYcX/
	qHCa8XaKgNBiZeowJDkDepIcjvpoWBmPXer3suneiMs5uvvtvz19QcX+1Hu3JFu/sm2iny0ZQzt
	9oVj3ecFlf/L6sAASKmMkCh/Cf7F40ZyoYTOmKOhl
X-Gm-Gg: AY/fxX5mVLmMJCHr14gRb//rEvKS0gTRZ/ELyFhmXKPXIYnRtYRxt4E37oDdvKjB4hj
	79nwgu7qa2ycLC1Ad9ULWS7BEvziPCkwo4zuRP+pDufCyhQU5mAVE8iaFPql6RfOET9vFvU0bEx
	wpThPs0P5qWTBweX2Y2ZqSgWkHO0zy1S5yR4etFwYuxrIAtgFeqMlHjSxSCoeLedBDJTPSsI10Q
	v8/4fYLiIt4VOfNDHln/jftXI1iGQH7H8W4Zx+nMBMf1caPJmtnPwAtCPDOswkRwc9la4zOJF8I
	urO3Tg==
X-Google-Smtp-Source: AGHT+IHpKtcGoaFcyM3/Nnwpgy7rFN8gVX4PgeFXdHVXhC+0aIRi5LCrcg4VI3/B0/Uxs1K2zrDKvlcc+64V830emrU=
X-Received: by 2002:a05:622a:1f8a:b0:4f1:83e4:70d0 with SMTP id
 d75a77b69052e-4f4aadb1131mr181306581cf.34.1766393469958; Mon, 22 Dec 2025
 00:51:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20251219025140.77695-1-jiayuan.chen@linux.dev>
In-Reply-To: <20251219025140.77695-1-jiayuan.chen@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 22 Dec 2025 09:50:58 +0100
X-Gm-Features: AQt7F2qlaUdi_Ael9gRYCKCL6sZMzKdOsY2sFDrI0SpdgEap_PpnZPFgW9I7Sh8
Message-ID: <CANn89iLeASUZyonYSLX0AG5mbC=gxux0efehkBc_j1bbj6xrvA@mail.gmail.com>
Subject: Re: [PATCH net v2] ipv6: fix a BUG in rt6_get_pcpu_route() under PREEMPT_RT
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, 
	syzbot+9b35e9bc0951140d13e6@syzkaller.appspotmail.com, 
	"David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Clark Williams <clrkwllms@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
	linux-rt-devel@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 19, 2025 at 3:52=E2=80=AFAM Jiayuan Chen <jiayuan.chen@linux.de=
v> wrote:
>
> On PREEMPT_RT kernels, after rt6_get_pcpu_route() returns NULL, the
> current task can be preempted. Another task running on the same CPU
> may then execute rt6_make_pcpu_route() and successfully install a
> pcpu_rt entry. When the first task resumes execution, its cmpxchg()
> in rt6_make_pcpu_route() will fail because rt6i_pcpu is no longer
> NULL, triggering the BUG_ON(prev). It's easy to reproduce it by adding
> mdelay() after rt6_get_pcpu_route().
>
> Using preempt_disable/enable is not appropriate here because
> ip6_rt_pcpu_alloc() may sleep.
>
> Fix this by:
> 1. Removing the BUG_ON and instead handling the race gracefully by
>    freeing our allocation and returning the existing pcpu_rt when
>    cmpxchg() fails.
> 2. Keeping the BUG_ON for non-PREEMPT_RT kernels, since preemption
>    should not occur in this context and a cmpxchg failure would
>    indicate a real bug.
>
> Link: https://syzkaller.appspot.com/bug?extid=3D9b35e9bc0951140d13e6
> Fixes: 951f788a80ff ("ipv6: fix a BUG in rt6_get_pcpu_route()")

I would rather find when PREEMPT_RT was added/enabled, there is no
point blaming such an old commit
which was correct at the time, and forcing pointless backports to old
linux kernels.
