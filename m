Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD1A2E49B1
	for <linux-rt-devel@lists.linux.dev>; Thu, 17 Jul 2025 15:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752766061; cv=none; b=EpdEJ3tbHazTlxAtZTbCeV6rceqhifwbP0+7Oip7Ar8PutS4FZKH1nP5/hNrx+x53lwXBuiBpToDawFVDzlBPFZDN+5lWXykrS4YVYJtD86tttSA4MXM7pfhUp1W1/SN/Y+v4cEl1yyMyIP2tVbi/sLfFyNalOmPx5bZCegjEAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752766061; c=relaxed/simple;
	bh=LhrFHpYsRnEHg0B/lmcoVHLZfq1NyHa1tH7Idp+Qoz0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YbWBzKStLZ7uK39Gvv4+Ri+tFjF4vlS26GTGC16/PxVGO777FFgTMMu2OFrYnGD5ohjjnDt045XBuSRSuEfpIVLj78x6SzpaushfjoPK5UYI0dlVR0UmVDit2gTG25O/TOzmy9zpxUju71pVt1LFG8L7Jq81tcfh3doNlQxji1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QDh1LOOD; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QDh1LOOD"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a54690d369so935189f8f.3
        for <linux-rt-devel@lists.linux.dev>; Thu, 17 Jul 2025 08:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752766058; x=1753370858; darn=lists.linux.dev;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LhrFHpYsRnEHg0B/lmcoVHLZfq1NyHa1tH7Idp+Qoz0=;
        b=QDh1LOODdPvXB/uuF02z9qq/orYw9HPrSGqkTDrq9plYN+gUdoZiCJ1kW+j9wt6FZy
         yEH7lYOflHh3h7WawsHvISxUJuDg5SFi+J5b6/dcfmHVTxamci89ovBGbeBWWuZxJ78q
         nlbStcgRpvSjPaWKDQD3Dv/vb+3ypxPsTW73G+ouJwvHmXqyksHPjQZ4GLm7j2l+MbPY
         KugpphDibD2v3mrl0AuP0wXMjA9ZXJfbC+7urQ14VLAELXZ2Gj1M5iRbh6wXv7vrb/nF
         g4YBpankyHra+3qIeOTweOLeNKpnv6ctkPa5CcgZoVylz5OoSTDuiyTr2TfT5fvZZmFC
         Fuew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752766058; x=1753370858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LhrFHpYsRnEHg0B/lmcoVHLZfq1NyHa1tH7Idp+Qoz0=;
        b=sJwnulQGbsRxE5YlLkSCiizgNZjxkhpf5Diij2y4TdGRVM9XwZe1Jz4v3xBc0GQODr
         4yCZikyfqoGBkTdlgKe1+JtKnycl0MYbkPttM1aPIPbaDBXqboxiM1l+G1GBmRh1H67N
         uaWdwD4YJQndcU+3lZpupGKOxyUvFoEXCjTy58WQ28iJviAmMwKG5kEn541Eu/jphFOg
         //xcsg8W6PX+eDXxXJ9N/OefKwVzVzgMXaN7Db2SNTgbRhOz7sD/wQmoR7NlspMqgVEo
         je56EjGqWkGKbH8PZJppwZTbFai07DfgYazXGsVqZvu5rN/GiMRsl1R6GNOoRagmL7Gv
         lIFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUjdrBEiy5TO1i4A9V5iRzr6ItD10TQQBEUNpbLfLgRiv3pLnVfq9ANvklmIXXDPJoF2w1xzV4vLX1/5D6eMA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyPbZkcA0Y4Khv+qqyN2gKsV02cImJGkdWMEN1mAjcA0W5e4sqK
	tLa9DZhj+yqS6HBUReMT7MgntVdCKAvxwI048t2zPdiH7QOiYtTQn+R2AQxU28qj/DSZ3lYT85t
	DswJMP5xOEfyrRQFBhSuo+YPiiBGGPK4=
X-Gm-Gg: ASbGncvBsOzaeLJv4sswkx2Pfiizv4kjtExn8APrkBHaGpz3NwPTj+N1/75AfdQlO/g
	dYUV9tz0PNJxMhklGahrn6SCcklZDIprheQHQ+tMFPDMDlMUy3XmKF4A4Df5pD4qObywVVTySol
	T1xD4OTqEsebnZmwI+0ZSAep0iDvaIVcSzXN/e2EkTgUkwego9HCmAqsrdHq1HDyNbj6Mp7rtnp
	hDYixBmpSzsEKSzJ4gzRSA=
X-Google-Smtp-Source: AGHT+IG8k6sso9++qlBvVzKzU6GGWQpGnwuYDmx/VuR8lzCOZhOVTOskA3kl3KXW2xQF9DvJIDyU9xRvxYQr+HGx64U=
X-Received: by 2002:a05:6000:402a:b0:3a5:27ba:47c7 with SMTP id
 ffacd0b85a97d-3b60e50ff6amr6259702f8f.48.1752766058238; Thu, 17 Jul 2025
 08:27:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <03083dee-6668-44bb-9299-20eb68fd00b8@paulmck-laptop>
 <fa80f087-d4ff-4499-aec9-157edafb85eb@paulmck-laptop> <29b5c215-7006-4b27-ae12-c983657465e1@efficios.com>
 <acb07426-db2f-4268-97e2-a9588c921366@paulmck-laptop> <ba0743dc-8644-4355-862b-d38a7791da4c@efficios.com>
 <512331d8-fdb4-4dc1-8d9b-34cc35ba48a5@paulmck-laptop> <bbe08cca-72c4-4bd2-a894-97227edcd1ad@efficios.com>
 <16dd7f3c-1c0f-4dfd-bfee-4c07ec844b72@paulmck-laptop> <20250716110922.0dadc4ec@batman.local.home>
 <895b48bd-d51e-4439-b5e0-0cddcc17a142@paulmck-laptop> <bb20a575-235b-499e-aa1d-70fe9e2c7617@paulmck-laptop>
 <e8f7829c-51c9-494a-827a-ee471b2e17cd@efficios.com> <CAADnVQL7gz3OwUVCzt7dbJHvZzOK1zC4AOgMDu5mg6ssKuYU6Q@mail.gmail.com>
 <20250717111216.4949063d@batman.local.home>
In-Reply-To: <20250717111216.4949063d@batman.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 17 Jul 2025 08:27:24 -0700
X-Gm-Features: Ac12FXzFRC8adLl7CZkn_RpMEeWocBjx5K-fqVR_zZuPS6uWVV2ffn0TRaEQxn4
Message-ID: <CAADnVQ+r8=Nw0fz8huFHDNe2Z6UnQNyqXW1=sMOrOGd8WniTyw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] rcu: Add rcu_read_lock_notrace()
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Boqun Feng <boqun.feng@gmail.com>, 
	linux-rt-devel@lists.linux.dev, rcu@vger.kernel.org, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	Frederic Weisbecker <frederic@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Josh Triplett <josh@joshtriplett.org>, Lai Jiangshan <jiangshanlai@gmail.com>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Uladzislau Rezki <urezki@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 8:12=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Thu, 17 Jul 2025 07:57:27 -0700
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
>
> > I still don't understand what problem is being solved.
> > As current tracepoint code stands there is no issue with it at all
> > on PREEMPT_RT from bpf pov.
> > bpf progs that attach to tracepoints are not sleepable.
> > They don't call rt_spinlock either.
> > Recognizing tracepoints that can sleep/fault and allow
> > sleepable bpf progs there is on our to do list,
> > but afaik it doesn't need any changes to tracepoint infra.
> > There is no need to replace existing preempt_disable wrappers
> > with sleepable srcu_fast or anything else.
>
> From the PREEMPT_RT point of view, it wants BPF to be preemptable. It
> may stop migration, but if someone adds a long running BPF program
> (when I say long running, it could be anything more than 10us), and it
> executes on a low priority task. If that BPF program is not preemptable
> it can delay a high priority task from running. That defeats the
> purpose of PREEMPT_RT.
>
> If this is unsolvable, then we will need to make PREEMPT_RT and BPF
> mutually exclusive in the configs.

Stop this fud, please.

bpf progs were preemptible for years and had no issue in RT.
tracepoints are using preempt_disable() still and that's a
tracepoint infra problem. Nothing to do with users of tracepoints.
