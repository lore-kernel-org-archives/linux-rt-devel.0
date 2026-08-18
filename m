Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 347E4190462
	for <linux-rt-devel@lists.linux.dev>; Tue, 18 Aug 2026 23:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787095565; cv=none; b=QvdFDSynp0LYvhAlN7xEhwcBdY+ZRfqL6M6hgiCttoRGm8v86a4RlQwMwfUQP3DGX8bEs1X9ODqQrMeqCbATlzR4eS4lY2tPTQHSo3uFdQZnfV8GbbphONGN/TZTIIDuNJ3BoRBDeMJujvqzpbpF6h36SKCZ5RslSBPhI+iZ0to=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787095565; c=relaxed/simple;
	bh=e6ndFhgPut4OMuMojKDPvfYXSEtrB68z8W/+iyMwO+U=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=YT8L3IeufGtk5iFPrNzL85H/kFYNSbbTFzjcfwsYCfVYPaFCIV/gsy0WGwNhXJYveEAKAAF2kGn8EpHpqfYCSxY/1bZ/YLMx4NXV9zbab6NHxySDmUbVlMFSrWdwhbs7Xa0GI5x1enfwl8+veQAMI2ethKqx55pluGsBFZ0OW/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=ag5PNGST; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b="ag5PNGST"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so628532a91.0
        for <linux-rt-devel@lists.linux.dev>; Tue, 18 Aug 2026 16:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1787095562; x=1787700362; darn=lists.linux.dev;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=jztQZP2aqNb9XCCcLuBxD5DTDOgUaHJEuB77MdCft9I=;
        b=ag5PNGST2cfctZm7k6wL/tBKyvhWTKg0rYq3sq3cLbBOrxwFTzSk8cnEnF+FyE9LpA
         HZ8k2ASRRYYfguwbp0je8ZpzORfzfSagrKHp7j7Oy7vsoRWnrcKEMQDXLzMHu8UsGbTD
         px3TkAW4GTb8S+T1qAfgalag+JMhXcPihFUjc1LEEAxiD3qh4P16ixwev7rUQc4M4Omj
         FwCsgWWY5oqcSz2FNyQ9HssUjfyOTg/8q3+eb+JflTsrx+22lBnfBrENkW+8fgbIsHjc
         DiIuGv3ASsPqNbpetsrX4xPbqVST2yV8y9fe33e0BB+b3bePlGpJafSx42/Z8zJL8fIH
         brMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787095562; x=1787700362;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jztQZP2aqNb9XCCcLuBxD5DTDOgUaHJEuB77MdCft9I=;
        b=oPgOmP2ovRntk/KXdo99kjaFCbFL4+vOs0UbwqgByGJu/FQfeHUQCFq+ftmrP46Ewd
         UQaeK4/Em8aOSd6zrAllfitCwlJtLV2kIBKg4cfusFcWpv0/2N5R4pgoIEr9UAW7OP1r
         SZZ/5sUc6t5Eum+odgd5+8oB0x7Rl+SQik5oKRfzWNP4Jp0ZX2i0GFTQ7CuyET5BjdnL
         Cs5geuv3sfJ6rqW6zcHnFUKHsmaviG8cyhE+U3ylRWvJ8azCEOyI2vmLPogfjw2GXBD6
         TP+SewMY5LKInmcr+hH9RGpjlY7kZ0n/fhShA19bwsikQK3hAMMVqmd10s/ufw2Ov/Oq
         y4hA==
X-Forwarded-Encrypted: i=1; AHgh+RqFY8r2sG/GC3rU2bgYP/c2+Ehis4z6XPMPmypmubYqU/QnS1uQ4TO9SosUNPzjQMLn4ZsT1ApTFppvRFGRzg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyglG+ykpxKmHid6qpX8c+U49Q27DkrLyvwIbkJ2UMQNSP+BG+H
	qEaDHAOR1bbABoc4t3E057vlOSxIWgHVjFwMORbCpHdgrRGYh2whw7EHgmdzBLnQLO0=
X-Gm-Gg: AR+sD10XoL4cpgcGu1rBx4ci3N1sT+QMIQqKqznFaIQRmv4a+bQHaYjM5MXP1LqJ7hI
	q9jfrZ+Kk9D12vrdeaR2rEp3U8pTIx8aVFaRGK7yRX0d7/BKIUlwsAbiC/jP/YNHRF4iHR3P73b
	NAVbNxJfALdZK/iPD33KYvr4GsmmY+No3OcNIEXZDf7wnyJp+1J4+tfcjTc3Wh/3sg0lMMYtvSv
	YGfHepQ+fxQcXQaVewukHZG88x+bxMG184d38KrTN0ByUmK8QkjJrFDiN3XyJKcaIWEcLGTTzlH
	F7tYoBtI3LhVswqwgIRq+M9Mu4u2eGFwxw32vGDqBJ4rP11cmkJ8iidQb4ap93/YmyoWpuyyUXT
	1eyVKV/xR7Ym7hdYULCk0TZ+7eOZbmEzT6v6tScAT6EymQNCNnm792oOs3+euKq5w3ieJ2xMcUU
	FCgOdPksnirYLUIuXF4z+zZ+Ea8p/a+QcJrQfn1bbCi9IDB7GgkhsGSzYm43iU//y/X+yWGad03
	/ZOu04w+LuhtM18F1oxYUzm3scU
X-Received: by 2002:a17:90b:5484:b0:37d:f983:7b5 with SMTP id 98e67ed59e1d1-3958110cfc4mr767267a91.9.1787095562358;
        Tue, 18 Aug 2026 16:26:02 -0700 (PDT)
Received: from localhost (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957f85cdddsm115192a91.3.2026.08.18.16.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Aug 2026 16:26:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rt-devel@lists.linux.dev
List-Id: <linux-rt-devel.lists.linux.dev>
List-Subscribe: <mailto:linux-rt-devel+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:linux-rt-devel+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 18 Aug 2026 19:26:00 -0400
Message-Id: <DKSGI6P7W52Z.3KO3SK2SG7EHG@etsalapatis.com>
To: "Jiayuan Chen" <jiayuan.chen@linux.dev>, <bpf@vger.kernel.org>
Cc: "Alexei Starovoitov" <ast@kernel.org>, "Daniel Borkmann"
 <daniel@iogearbox.net>, "Andrii Nakryiko" <andrii@kernel.org>, "Eduard
 Zingerman" <eddyz87@gmail.com>, "Kumar Kartikeya Dwivedi"
 <memxor@gmail.com>, "Martin KaFai Lau" <martin.lau@linux.dev>, "Song Liu"
 <song@kernel.org>, "Yonghong Song" <yonghong.song@linux.dev>, "Jiri Olsa"
 <jolsa@kernel.org>, "Emil Tsalapatis" <emil@etsalapatis.com>, "Ihor
 Solodrai" <ihor.solodrai@linux.dev>, "John Fastabend"
 <john.fastabend@gmail.com>, "Shuah Khan" <shuah@kernel.org>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, "Clark Williams"
 <clrkwllms@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>,
 <linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH bpf-next v3 3/4] selftests/bpf: Add read_cgroup_file()
 to cgroup_helpers
From: "Emil Tsalapatis" <emil@etsalapatis.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260808140720.293604-1-jiayuan.chen@linux.dev>
 <20260808140720.293604-4-jiayuan.chen@linux.dev>
In-Reply-To: <20260808140720.293604-4-jiayuan.chen@linux.dev>

On Sat Aug 8, 2026 at 10:05 AM EDT, Jiayuan Chen wrote:
> cgroup_helpers has write_cgroup_file()/write_cgroup_file_parent() but no
> read counterpart. Add read_cgroup_file() and read_cgroup_file_parent() so
> a forked child can read a cgroup file (e.g. memory.current) from the work
> dir owned by the parent that set the environment up, without hand-buildin=
g
> the /mnt/... path.
>
> Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>

Reviewed-by: Emil Tsalapatis <emil@etsalapatis.com>

The "- 24" is questionable, but it's already all over the file. We can
clean it up separately.

> ---
>  tools/testing/selftests/bpf/cgroup_helpers.c | 67 ++++++++++++++++++++
>  tools/testing/selftests/bpf/cgroup_helpers.h |  4 ++
>  2 files changed, 71 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/cgroup_helpers.c b/tools/testing=
/selftests/bpf/cgroup_helpers.c
> index 45cd0b479fe3..4183ff6150c2 100644
> --- a/tools/testing/selftests/bpf/cgroup_helpers.c
> +++ b/tools/testing/selftests/bpf/cgroup_helpers.c
> @@ -188,6 +188,73 @@ int write_cgroup_file_parent(const char *relative_pa=
th, const char *file,
>  	return __write_cgroup_file(cgroup_path, file, buf);
>  }
> =20
> +static int __read_cgroup_file(const char *cgroup_path, const char *file,
> +			      char *buf, size_t len)
> +{
> +	char file_path[PATH_MAX + 1];
> +	ssize_t got;
> +	int fd;
> +
> +	snprintf(file_path, sizeof(file_path), "%s/%s", cgroup_path, file);
> +	fd =3D open(file_path, O_RDONLY);
> +	if (fd < 0) {
> +		log_err("Opening %s", file_path);
> +		return 1;
> +	}
> +
> +	got =3D read(fd, buf, len - 1);
> +	if (got < 0) {
> +		log_err("Reading %s", file_path);
> +		close(fd);
> +		return 1;
> +	}
> +	buf[got] =3D '\0';
> +	close(fd);
> +	return 0;
> +}
> +
> +/**
> + * read_cgroup_file() - Read from a cgroup file
> + * @relative_path: The cgroup path, relative to the workdir
> + * @file: The name of the file in cgroupfs to read from
> + * @buf: Buffer to read into, NUL-terminated on success
> + * @len: Size of @buf
> + *
> + * Read from a file in the given cgroup's directory.
> + *
> + * If successful, 0 is returned.
> + */
> +int read_cgroup_file(const char *relative_path, const char *file,
> +		     char *buf, size_t len)
> +{
> +	char cgroup_path[PATH_MAX - 24];
> +
> +	format_cgroup_path(cgroup_path, relative_path);
> +	return __read_cgroup_file(cgroup_path, file, buf, len);
> +}
> +
> +/**
> + * read_cgroup_file_parent() - Read from a cgroup file in the parent pro=
cess
> + *                             workdir
> + * @relative_path: The cgroup path, relative to the parent process workd=
ir
> + * @file: The name of the file in cgroupfs to read from
> + * @buf: Buffer to read into, NUL-terminated on success
> + * @len: Size of @buf
> + *
> + * Read from a file in the given cgroup's directory under the parent pro=
cess
> + * workdir.
> + *
> + * If successful, 0 is returned.
> + */
> +int read_cgroup_file_parent(const char *relative_path, const char *file,
> +			    char *buf, size_t len)
> +{
> +	char cgroup_path[PATH_MAX - 24];
> +
> +	format_parent_cgroup_path(cgroup_path, relative_path);
> +	return __read_cgroup_file(cgroup_path, file, buf, len);
> +}
> +
>  /**
>   * setup_cgroup_environment() - Setup the cgroup environment
>   *
> diff --git a/tools/testing/selftests/bpf/cgroup_helpers.h b/tools/testing=
/selftests/bpf/cgroup_helpers.h
> index 3857304be874..d42d2e13044e 100644
> --- a/tools/testing/selftests/bpf/cgroup_helpers.h
> +++ b/tools/testing/selftests/bpf/cgroup_helpers.h
> @@ -15,6 +15,10 @@ int write_cgroup_file(const char *relative_path, const=
 char *file,
>  		      const char *buf);
>  int write_cgroup_file_parent(const char *relative_path, const char *file=
,
>  			     const char *buf);
> +int read_cgroup_file(const char *relative_path, const char *file,
> +		     char *buf, size_t len);
> +int read_cgroup_file_parent(const char *relative_path, const char *file,
> +			    char *buf, size_t len);
>  int cgroup_setup_and_join(const char *relative_path);
>  int get_root_cgroup(void);
>  int create_and_get_cgroup(const char *relative_path);

