Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B07D35E940
	for <linux-rt-devel@lists.linux.dev>; Thu,  9 Jul 2026 17:03:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783616619; cv=pass; b=q8wEYdJkj7gyEx6fqrreRQfhuD+U763aipHxgX51dcgUxXCVAAJF6ZqRe2sSuUSNcAF+OL8mq/Jw2LlW514ljJ/v8YlRVyGldDxhPuC9jRntHEyc77ag6kWL3P4t8rMkn362wMKEH1iJ7XmxjZ5J7j6XKiIZ85rWP1rWSp8632Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783616619; c=relaxed/simple;
	bh=YewI3WK0FI+k+A8vApRuZn3wTz1R19tXNTxrVUVVf90=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tfMLNlZNit1OC+KMA78TM15asVo2EYvU9fO4nKBa1NpWKxvAvlflMrLw7aRkTWIsit5QNV6QSez6AlYU6DndLJYROQFrVUfXPC6tIPzpJ9zGtfWXSciuiYrFirMrsUuJeM5lDCLNdAuLPtMvN5kAggusLG5hCINaHdrM5PJap6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R7wmDjVU; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R7wmDjVU"
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-664b05d408bso10415d50.1
        for <linux-rt-devel@lists.linux.dev>; Thu, 09 Jul 2026 10:03:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783616616; cv=none;
        d=google.com; s=arc-20260327;
        b=ozYtPTWnwAj9UH9TGjGwCh3xtMgtRyuyYzxGsBAgvRPjuQz81kdzOoEiUJHXbJUf3m
         pHk0JVozsIEKQD3pSvoLpTEtDAFmY7TQjOOzjwIuPpm2zBYGJX4kLzIM31Zf1jB3jCbD
         6wpXBXNnmq82v/F1HqxKgZHr67RyMMb6rwcRvO83kAUn0uMF3HjHpaeaRWljQnu7Hw+X
         C7oywJ/NdKd7/VPZgUJODWJxsD3HGI2konaCcKlH9lENs/m13RDzyezpolP1vXwD8lir
         Acn/FCXq9yYcjiXX6hq8ykkFiMjGIfnUzF5gCpQoQtiiXAGttJxlC33JLK4Olqq7plZw
         I0FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yR14oOjUi6OI2bUfX4NS8nwAQpf3oK/jBWo0jGsJb5s=;
        fh=3EM//Sh09se5QXq9XlYfHBis6CqD21ALsV6zk3qbvHY=;
        b=oq8had4Bx56zJXAqqSx3UZlRbxMyc3yU3tcupfqO3gDCHpO11a3ZACMj2S25xdpf7g
         VFkLos2zQbRq+U37QezhO9LPVmenUZOlO0C6+EeSWQn8Qh1y++jd6pZ02H3yJvG4kSJG
         qJHA/0FU4suTPPgEY4ZGaaDkDRomZmidiR23Swi2/OU4xzaRfTHfJWlD7q4F2fKwXXLA
         nXeOaacu4HFH9w0p/elVZKJs6mX+3bgRCFS0CIoOQfZ1W3CjMZpf0VQ+lEEM/SiFOf+d
         8Xo/CzrG1ixehGhGFHwiU5iWGxJwAFsNJVUi2jxf3CmcgRV7QcGTQLlvi325kYgKwqP4
         8xcw==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1783616616; x=1784221416; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=yR14oOjUi6OI2bUfX4NS8nwAQpf3oK/jBWo0jGsJb5s=;
        b=R7wmDjVU6yKTsIJx19RgcU4FjQoT7eEQAjq4ZFgrKvWXxmn/TZlI7asKN0QRU+uehs
         pUWQPxuJUm6IGHffCM0WrbAlkQlTnK6ODjFNZ4aOaqvLw0lbzQuroi81vh4FwCJav670
         fetpdsDokSt2bwopSbiDPbfMZI3QgsQG89xkhe1zXqw/5MkU/8foRErLD/ukm81FSkrM
         PIN+yqWGPw9JNUHXiEmumw5LgTQO4xHcSD8f9PDIX8CB9Wn/9On+fEUPOBaBAb8OYABk
         GwrU8I0cdMSkTDU13CGrX17BUjfi/HvIduyKUTtehQg2ZouqApC086pjP3T2rP0v0ym4
         0sbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783616616; x=1784221416;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yR14oOjUi6OI2bUfX4NS8nwAQpf3oK/jBWo0jGsJb5s=;
        b=ozAkJaKPe9Rse7m5jtaqXKdYdo0O5qASuBh+mhrdw6fFqcPst0raRKvZ6LFrBtXuUC
         uWbS7ozmigvuOAsFZPntw5XkzooMcFNwhxF0T3zmujeh+iZW6dLjTF2NWDIYxVDCTazr
         2cynAkRMmrqi5hIqy/CgciH4g6N0LXLsBE2nwxSxvOJdyr+e1DAu+XJRMB3Rn3CHAMKy
         ICBXjz/jC9344NPhP008JtcD3Na+8Yt3v3e2J+R3r1PNS1L0VkEKzKulkh7qERzmUuZK
         8/jIcsUSYgbN9eoo4rzs0PPnccEReaZ+Q7ChL3qdSq53a6prznII+RcaRTuoDVx+OWWH
         kJMg==
X-Gm-Message-State: AOJu0YzlwAmR89qTTUSVNqHtr3K/nJjHK20vaZ3FIe0MuBmPaBwbv0Oa
	+R+61u2HsY16mWiV3dDnUzSFfET+6Ren/7JGoE8jHsEMReZk2vLL4veCCvxYHLp1NjWxDgW5oWJ
	7QP2+ez+Z2DhB+AxKkTt0UZ/RV3Nc5YDORhfdFtl/1Q==
X-Gm-Gg: AfdE7cnK1ZL8PQTidfHQADkLdLQl2zNUmNpOD4mH+yz3TfccnZqwI73jMGAXqAQNCSU
	SLk/y3Opb2c2lD4Oy9QsiVmb24ki+oGIWO9FVv3YpOMyvDYGyOUfczAFJTeZJDMNc4COivSrf/5
	mTDiOGlSu5d9nCL/xE/pplAZGN+7zORIgqdI1gHp621CPAQLZFfvwkqFkC9kZmRVrskBvAvN0zf
	ta/VP1AA1MZ0fYCIe997hnE7buBdpXyrIu/shnAhxHltZ9UtxWOCnIEoNZ8Nnl0lUD9l9nTbhga
	lj/Km68nDvvuNdL7IZkjgtDYtmnNAt/H1Z07GPn013jTV71+8npzkYyRSb94FLQjXNxiegl65+S
	cRI2gU7eAaOf9ijvuN2fU0QpIWiyJIcvsEedOK6xTYlYcRKM90UTh2sj0wTEt81Y3QgDGdVuTET
	nOfVHMST1OSGRvrzE05aMX2ACiF9z1L8xcBa4bqIUplpKPJ6ckSMJowJmMyINjtSsTBC2RKiGed
	+Wr9W9FNWaBdwqWPnMi+7sakNJG9hkJHHqe54LsAZCCX0z+f88kF5a3nAhGUfYgvgnTq88/5lWT
	ZH3vi81AbGAtlwn92ZCASqe6r0Zjp6h9N7EOmUwXuMFB0x+GBGOZ/VEaV+DK1qR117DtBaLz
X-Received: by 2002:a53:5a08:0:b0:667:8b91:2439 with SMTP id
 956f58d0204a3-6679f26f7a1mr4147877d50.104.1783616616104; Thu, 09 Jul 2026
 10:03:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260701091226.7SWW4TrT@linutronix.de>
In-Reply-To: <20260701091226.7SWW4TrT@linutronix.de>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Thu, 9 Jul 2026 20:03:00 +0300
X-Gm-Features: AVVi8CeGWVzdbJXgI7g1MhHGlIvtNbOsamz5SlMClo5-ZNqp3TXp_jMt7pChNFA
Message-ID: <CAC_iWjKEcK8Z2TGCAVNU+pHLO2QvKKTmA01d-EqhE6exaTKcsQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: Extend the real-time hardware bits with
 some firmware bits
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, "jenswi@kernel.org" <jenswi@kernel.org>
Cc: linux-rt-devel@lists.linux.dev, linux-doc@vger.kernel.org, 
	linux-efi@vger.kernel.org, op-tee@lists.trustedfirmware.org, 
	Ard Biesheuvel <ardb@kernel.org>, Clark Williams <clrkwllms@kernel.org>, 
	Jan Kiszka <jan.kiszka@siemens.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Steven Rostedt <rostedt@goodmis.org>, 
	John Ogness <john.ogness@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

++Cc Jens  on his kernel.org email

On Wed, 1 Jul 2026 at 12:12, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> I have been reviewing how OP=E2=80=91TEE is implemented and how secure=E2=
=80=91world
> invocations behave. The goal was to determine whether an OP=E2=80=91TEE c=
all can
> delay the Linux side and introduce latency depending on the time spent
> in the secure world.
>
> Similar latency effects are already known for EFI runtime services, but
> this was not documented. To mitigate the impact, EFI runtime invocations
> can be restricted to specific CPUs so that real=E2=80=91time workloads on=
 other
> CPUs remain unaffected. This mechanism, however, is only described in
> the commit that introduced it.
>
> This change adds a firmware section that documents these behaviours
> explicitly. It highlights cases where firmware can delay the kernel,
> information that may be unfamiliar to some users and surprising-or
> concerning-to others.
>
> Assisted-by: Microsoft-Copilot
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>
> I would appreciate an ACK from the OP-TEE camp that I got my little
> research right.
>
>  Documentation/core-api/real-time/hardware.rst | 92 +++++++++++++++++++
>  1 file changed, 92 insertions(+)
>
> diff --git a/Documentation/core-api/real-time/hardware.rst b/Documentatio=
n/core-api/real-time/hardware.rst
> index 19f9bb3786e03..fb113848c2f70 100644
> --- a/Documentation/core-api/real-time/hardware.rst
> +++ b/Documentation/core-api/real-time/hardware.rst
> @@ -130,3 +130,95 @@ https://github.com/Linutronix/RTC-Testbench.
>  The goal of this project is to validate real-time network communication.=
 It can
>  be thought of as a "cyclictest" for networking and also serves as a star=
ting
>  point for application development.
> +
> +Firmware
> +--------
> +
> +The firmware often plays a significant role in system operation because =
it can
> +perform tasks that the kernel cannot directly access, and in some cases =
it can
> +even preempt or intercept the kernel.
> +
> +A common example of firmware assisting the kernel is when it provides a =
generic
> +interface to a resource. Instead of accessing an RTC chip through an I2C=
 host
> +controller, the kernel may query the firmware for the current time, and =
the
> +firmware then accesses the RTC behind the scenes.
> +
> +Firmware can also intercept kernel execution by providing services that
> +temporarily take control of the system. One example is memory scrubbing,=
 where
> +the firmware periodically pauses the kernel, reads back portions of syst=
em
> +memory, and then returns control. During this time, the kernel is effect=
ively
> +interrupted.
> +In contrast, some systems provide hardware=E2=80=91based memory scrubbin=
g, which
> +operates independently of firmware or software. See
> +Documentation/edac/scrub.rst for details.
> +
> +If the kernel is intercepted for longer periods then these periods can b=
e made
> +visible with the hardware latency detector. See
> +Documentation/trace/hwlat_detector.rst.
> +
> +The kernel can also be intercepted in response to specific events, such =
as
> +overheating. In this case, the firmware may throttle the CPU or shut it =
down
> +immediately to prevent hardware damage.
> +
> +Unless the firmware is well documented, it should be thoroughly tested t=
o
> +uncover any unexpected behaviour.
> +
> +EFI
> +~~~~
> +
> +EFI provides runtime services that act as a communication interface betw=
een the
> +firmware and the operating system. One such service is reading and writi=
ng EFI
> +variables, which are used, for example, to determine the boot source.
> +
> +Invoking a runtime service may require the architecture to disable kerne=
l
> +preemption or interrupts during the call. This means the duration of a s=
ervice
> +invocation directly affects the system=E2=80=99s observable latency. The=
re is also
> +nothing that prevents a service call from disabling interrupts internall=
y while
> +it runs.
> +
> +For these reasons, EFI runtime services are disabled by default on a PRE=
EMPT_RT
> +kernel. They can still be enabled at boot time or via a Kconfig option i=
f
> +required.
> +The native EFI runtime service implementation (where both the EFI servic=
e and
> +the kernel are either 32=E2=80=91bit or 64=E2=80=91bit executables) uses=
 a wrapper mechanism
> +that invokes the service through a dedicated workqueue. This workqueue i=
s named
> +efi_runtime, and it can be restricted to a housekeeping CPU using the
> +``/sys/devices/virtual/workqueue/efi_runtime/cpumask`` sysfs file. Assig=
ning it
> +to a housekeeping CPU ensures that potentially long service invocations =
do not
> +impact the real=E2=80=91time workload which is restricted to other CPUs.
> +
> +It must also be verified that the runtime services behave as expected. S=
ome
> +implementations on the x86 architecture pause all other CPUs while one C=
PU
> +performs the service call. In such cases, the interruption affects all C=
PUs,
> +and restricting the workqueue to a single CPU provides no benefit.
> +
> +OP-TEE (ARM)
> +~~~~~~~~~~~~
> +
> +OP=E2=80=91TEE uses a global serialization mechanism (the "big lock"), e=
nsuring that on
> +each core only one OP=E2=80=91TEE thread executes secure=E2=80=91world c=
ode at a time.
> +
> +Execution flows from the normal world (Linux) into the secure world (OP=
=E2=80=91TEE)
> +through the secure monitor at EL3. Linux and OP=E2=80=91TEE cannot disab=
le or mask each
> +other=E2=80=99s interrupts because both run at EL1 in different security=
 states.
> +
> +Architecturally, the secure monitor can mask or reroute normal=E2=80=91w=
orld interrupts
> +before entering the secure world. In a correct OP=E2=80=91TEE/ TF=E2=80=
=91A implementation, it
> +does not do this for the duration of secure calls. Normal=E2=80=91world =
interrupts
> +remain deliverable, and a normal=E2=80=91world IRQ will preempt OP=E2=80=
=91TEE via EL3 and
> +return control to Linux.
> +
> +Secure=E2=80=91world interrupts (FIQs) are possible if the SoC routes a =
device's
> +interrupt as secure. Such a secure FIQ will preempt Linux immediately, t=
rap
> +into EL3, and transfer control to OP=E2=80=91TEE's secure interrupt hand=
ler. Linux
> +cannot mask or preempt this. Secure FIQ handlers must therefore be extre=
mely
> +short to avoid introducing noticeable latency.
> +
> +The transition from normal world -> secure monitor -> OP=E2=80=91TEE and=
 back introduces
> +additional latency due to world switching and context save/ restore. Thi=
s
> +overhead is typically a few microseconds and usually remains in the nois=
e
> +floor.
> +
> +If the secure monitor masks normal=E2=80=91world interrupts during OP=E2=
=80=91TEE invocations,
> +or if OP=E2=80=91TEE uses long=E2=80=91running secure FIQ handlers, then=
 OP=E2=80=91TEE can introduce
> +measurable latency spikes.
> --
> 2.53.0
>
